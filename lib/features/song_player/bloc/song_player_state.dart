part of 'song_player_bloc.dart';

class SongPlayerState {
  SongPlayerStatus songPlayerStatus;
  int currentIndex;
  Duration songDuration;
  Duration songPosition;
  bool changeButton;
  SongPlayerState({
    required this.songPlayerStatus,
    required this.songDuration,
    required this.songPosition,
    required this.currentIndex,
    required this.changeButton,
  });
  SongPlayerState copyWith ({
    SongPlayerStatus? newSongPlayerStatus,
    Duration? newSongPosition,
    Duration? newSongDuration,
    int? newCurrentIndex,
    bool? newChangeButton,
  }){
    return SongPlayerState(
      songPlayerStatus: newSongPlayerStatus ?? songPlayerStatus,
      songDuration:  newSongDuration ?? songDuration,
      songPosition:  newSongPosition ?? songPosition,
      currentIndex: newCurrentIndex ?? currentIndex,
      changeButton: newChangeButton ?? changeButton
    );
  }
}


