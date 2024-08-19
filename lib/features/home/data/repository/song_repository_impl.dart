import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/common/error_handling/data_state.dart';
import 'package:spotify/common/error_handling/firebase_check_exception.dart';
import 'package:spotify/features/home/data/source/remote/song_firebase_service.dart';
import 'package:spotify/features/home/domain/repositroy/song_repository.dart';
import 'package:spotify/locator.dart';

class SongRepositoryImpl extends SongRepository{

  @override
  Future<DataState> getNewSongsRepository() async {
    try{
      var songs = await locator<SongFirebaseService>().getNewsSongs();
      return DataSuccess(songs);
    } on FirebaseException catch(e){
      return FirebaseCheckException.getError(e);
    }
  }

  @override
  Future<DataState> addOrRemoveFavoriteSongsRepository(String songId) async{
    try{
      var addFavoriteSong = await locator<SongFirebaseService>().addOrRemoveFavoriteSongs(songId);
      return DataSuccess(addFavoriteSong);
    } on FirebaseException catch(e){
      return FirebaseCheckException.getError(e);
    }
  }

  @override
  Future<DataState> isFavoriteSongRepository(String songId) async{
    try{
      var isFavorite = await locator<SongFirebaseService>().isFavoriteSong(songId);
      return DataSuccess(isFavorite);
    } on FirebaseException catch(e){
      return FirebaseCheckException.getError(e);
    }
  }

  @override
  Future<DataState> getUserFavoriteSongs() async {
    try{
      var favoriteSongs = await locator<SongFirebaseService>().getUserFavoriteSongs();
      return DataSuccess(favoriteSongs);
    } on FirebaseException catch(e){
      return FirebaseCheckException.getError(e);
    }
  }
}