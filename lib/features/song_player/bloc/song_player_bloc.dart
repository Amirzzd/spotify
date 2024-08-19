import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/features/song_player/bloc/song_player_status.dart';

part 'song_player_event.dart';
part 'song_player_state.dart';

class SongPlayerBloc extends Bloc<SongPlayerEvent, SongPlayerState> {
  late AudioPlayer audioPlayer = AudioPlayer();
  SongPlayerBloc() : super(
      SongPlayerState(
        songPlayerStatus: SongPlayerLoading(),
        songPosition: Duration.zero,
        songDuration: Duration.zero,
        currentIndex: 0,
        changeButton: false,
      )
  ) {
    ///listen to change
    audioPlayer.positionStream.listen((position){
      emit(state.copyWith(newSongPlayerStatus: SongPlayerSuccess(),newSongPosition: position));
    });

    audioPlayer.durationStream.listen((duration){
      emit(state.copyWith(newSongPlayerStatus: SongPlayerSuccess(),newSongDuration: duration));
    });

    on<SongPlayerEvent>((event, emit) async{

      ///---load
      if(event is LoadSong){


        try{
          emit(state.copyWith(newSongPlayerStatus: SongPlayerSuccess()));
          await audioPlayer.setUrl(event.url);
        }catch (e){
          emit(state.copyWith(newSongPlayerStatus: SongPlayerFailed()));
        }
      }

      ///--- play or pause
      if(event is PlayOrPauseSong){
        if(audioPlayer.playing){
          emit(state.copyWith(newSongPlayerStatus: SongPlayerSuccess()));
          await audioPlayer.stop();
        }else{
          emit(state.copyWith(newSongPlayerStatus: SongPlayerSuccess()));
          await audioPlayer.play();
        }
      }

      ///--- next song
      if(event is PlayNextSong){
        state.currentIndex = event.nextSongIndex;
        if(state.currentIndex < event.length - 1){
          emit(state.copyWith(newCurrentIndex: state.currentIndex ++));
        } else {
          emit(state.copyWith(newCurrentIndex: 0));
        }
      }

      ///--- previous song
      if(event is PlayPreviousSong){
        state.currentIndex = event.index;
        if(state.currentIndex > 0 ){
          emit(state.copyWith(newCurrentIndex: state.currentIndex --));
        } else {
          ///--- for loop
          emit(state.copyWith(newCurrentIndex: 3));
        }
      }

      ///---slider
      if(event is SliderChanged){
        Duration duration = Duration(seconds: event.value.toInt());
        audioPlayer.seek(duration);
      }

    },
    );
  }
}