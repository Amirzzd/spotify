part of 'song_player_bloc.dart';

sealed class SongPlayerEvent {}

class LoadSong extends SongPlayerEvent{
  String url;

  LoadSong({required this.url});
}

class PlayOrPauseSong extends SongPlayerEvent {}

class PlayNextSong extends SongPlayerEvent {
  int nextSongIndex;
  final int length;

  PlayNextSong({required this.nextSongIndex,required this.length});
}

class PlayPreviousSong extends SongPlayerEvent {
  final int length;
  final int index;
  PlayPreviousSong({required this.length,required this.index});
}

class SliderChanged extends SongPlayerEvent{
  double value;
  SliderChanged({required this.value});
}

class UpdatePosition extends SongPlayerEvent {
  Duration position;

  UpdatePosition({required this.position});
}
class UpdateDuration extends SongPlayerEvent {
  Duration duration;

  UpdateDuration({required this.duration});
}
