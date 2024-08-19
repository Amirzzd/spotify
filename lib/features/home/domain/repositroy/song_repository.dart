import 'package:spotify/common/error_handling/data_state.dart';

abstract class SongRepository {
  Future <DataState<dynamic>> getNewSongsRepository();
  Future <DataState<dynamic>> addOrRemoveFavoriteSongsRepository(String songId);
  Future <DataState<dynamic>> isFavoriteSongRepository(String songId);
  Future <DataState<dynamic>> getUserFavoriteSongs();
}