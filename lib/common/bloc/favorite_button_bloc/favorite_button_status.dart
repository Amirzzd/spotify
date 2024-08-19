part of 'favorite_button_bloc.dart';


abstract class FavoriteButtonStatus{}

class FavoriteButtonInitial extends FavoriteButtonStatus{}

class FavoriteButtonSuccess extends FavoriteButtonStatus{
  bool isFavorite;

  FavoriteButtonSuccess({required this.isFavorite});
}

