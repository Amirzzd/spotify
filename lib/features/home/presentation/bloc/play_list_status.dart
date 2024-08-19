part of 'songs_bloc.dart';


abstract class PlayListStatus{}

class PlayListInitial extends PlayListStatus{}

class PlayListLoading extends PlayListStatus{}
class PlayListSuccess extends PlayListStatus{
  final List<SongEntities> playListSong;

  PlayListSuccess({required this.playListSong});
}

class PlayListFailed extends PlayListStatus{
  final String message;

  PlayListFailed({required this.message});
}