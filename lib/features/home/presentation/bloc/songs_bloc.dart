import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotify/common/error_handling/data_state.dart';
import 'package:spotify/features/home/domain/entities/song_entities.dart';
import 'package:spotify/features/home/domain/usecase/get_favorite_songs_use_case.dart';
import 'package:spotify/features/home/domain/usecase/new_song_use_case.dart';
import 'package:spotify/locator.dart';

part 'songs_event.dart';
part 'songs_state.dart';
part 'new_songs_status.dart';
part 'get_user_favorite_songs_status.dart';
part 'play_list_status.dart';

class SongsBloc extends Bloc<SongsEvent, SongState> {
  List<SongEntities> favoriteSongs = [];
  SongsBloc() : super(SongState(
      newsSongsStatus: NewSongsLoading(),
      playListStatus: PlayListLoading(),
      getUserFavoriteSongsStatus: GetUserFavoriteSongsLoading()
  )) {
    on<SongsEvent>((event, emit) async {

      ///--- get new song
      if(event is GetNewSongsEvent){
        DataState dataState = await locator<NewSongUseCase>().call();
        dataState is DataSuccess
        ? emit(state.copyWith(newNewSongStatus: NewSongsSuccess(newSongs: dataState.data)))
        : emit(state.copyWith(newNewSongStatus: NewSongsFailed(message: dataState.message ?? '')));
      }

      ///--- play list
      if(event is GetPlayListEvent){
        DataState dataState = await locator<NewSongUseCase>().call();
        dataState is DataSuccess
        ? emit(state.copyWith(newPlayListStatus: PlayListSuccess(playListSong: dataState.data)))
        : emit(state.copyWith(newPlayListStatus: PlayListFailed(message: dataState.message!)));
      }

      if(event is GetUserFavoriteSongsEvent){
        DataState dataState = await locator<GetFavoriteSongsUseCase>().call();
        if(dataState is DataSuccess) {
          favoriteSongs = dataState.data;
          emit(state.copyWith(newGetUserFavoriteSongStatus: GetUserFavoriteSongsSuccess(favoriteSongs: favoriteSongs)));
        }else {
          emit(state.copyWith(newGetUserFavoriteSongStatus: GetUserFavoriteSongsFailed(message: dataState.message!)));
        }
      }

      if(event is RemoveSong){
        favoriteSongs.removeAt(event.index);
        emit(state.copyWith(newGetUserFavoriteSongStatus: GetUserFavoriteSongsSuccess(favoriteSongs: favoriteSongs)));
      }
    });
  }
}
