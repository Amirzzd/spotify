part of 'songs_bloc.dart';


abstract class GetUserFavoriteSongsStatus{}

class GetUserFavoriteSongsInitial extends GetUserFavoriteSongsStatus{}

class GetUserFavoriteSongsLoading extends GetUserFavoriteSongsStatus{}

class GetUserFavoriteSongsSuccess extends GetUserFavoriteSongsStatus{
  final List<SongEntities> favoriteSongs;

  GetUserFavoriteSongsSuccess({required this.favoriteSongs});
}

class GetUserFavoriteSongsFailed extends GetUserFavoriteSongsStatus{
  final String message;

  GetUserFavoriteSongsFailed({required this.message});
}