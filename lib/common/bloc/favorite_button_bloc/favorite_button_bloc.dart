import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotify/features/home/domain/usecase/add_or_remove_favorite_usecase.dart';
import 'package:spotify/features/home/domain/usecase/favorite_song_use_case.dart';
import 'package:spotify/locator.dart';
import '../../error_handling/data_state.dart';
part 'favorite_button_event.dart';
part 'favorite_button_state.dart';
part 'favorite_button_status.dart';

class FavoriteButtonBloc extends Bloc<FavoriteButtonEvent, FavoriteButtonState> {
  FavoriteButtonBloc() : super(
    FavoriteButtonState(
      favoriteButtonStatus: FavoriteButtonInitial()
    )
  ) {
    on<FavoriteButtonEvent>((event, emit) async {
      if(event is UpdateButton){
        DataState dataState = await locator<AddOrRemoveFavoriteUsecase>().call(param: event.songId);
        if(dataState is DataSuccess) emit(state.copyWith(newFavoriteButtonStatus: FavoriteButtonSuccess(isFavorite: dataState.data)));
      }
     },
    );
  }
}
