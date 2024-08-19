part of 'songs_bloc.dart';


abstract class NewSongsStatus{}

class NewSongsInitial extends NewSongsStatus{}

class NewSongsLoading extends NewSongsStatus{}
class NewSongsSuccess extends NewSongsStatus{
  final List<SongEntities> newSongs;

  NewSongsSuccess({required this.newSongs});
}

class NewSongsFailed extends NewSongsStatus{
  final String message;

  NewSongsFailed({required this.message});
}