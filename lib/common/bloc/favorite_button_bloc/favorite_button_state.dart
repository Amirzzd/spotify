part of 'favorite_button_bloc.dart';

class FavoriteButtonState {
  FavoriteButtonStatus favoriteButtonStatus;
  FavoriteButtonState({
    required this.favoriteButtonStatus,
  });
  FavoriteButtonState copyWith ({
    FavoriteButtonStatus? newFavoriteButtonStatus,
    bool ? newIsFavorite
  }){
    return FavoriteButtonState(
        favoriteButtonStatus: newFavoriteButtonStatus ?? favoriteButtonStatus
    );
  }
}


