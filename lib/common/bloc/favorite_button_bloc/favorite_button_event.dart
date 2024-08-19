part of 'favorite_button_bloc.dart';

@immutable
sealed class FavoriteButtonEvent {}

class UpdateButton extends FavoriteButtonEvent{
  final String songId;

  UpdateButton({required this.songId});
}