part of 'songs_bloc.dart';

@immutable
sealed class SongsEvent {}

class GetNewSongsEvent extends SongsEvent{}

class GetPlayListEvent extends SongsEvent{}

class GetUserFavoriteSongsEvent extends SongsEvent{}

class RemoveSong extends SongsEvent{
  final int index;
  RemoveSong({required this.index});
}