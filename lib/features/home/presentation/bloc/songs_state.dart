part of 'songs_bloc.dart';

class SongState {
  GetUserFavoriteSongsStatus getUserFavoriteSongsStatus;
  NewSongsStatus newsSongsStatus;
  PlayListStatus playListStatus;
  SongState({
    required this.newsSongsStatus,
    required this.playListStatus,
    required this.getUserFavoriteSongsStatus
});
  SongState copyWith ({
    NewSongsStatus? newNewSongStatus,
    PlayListStatus? newPlayListStatus,
    GetUserFavoriteSongsStatus? newGetUserFavoriteSongStatus
  }){
    return SongState(
      newsSongsStatus: newNewSongStatus ?? newsSongsStatus,
      playListStatus: newPlayListStatus ?? playListStatus,
      getUserFavoriteSongsStatus: newGetUserFavoriteSongStatus ?? getUserFavoriteSongsStatus,
    );
  }
}


