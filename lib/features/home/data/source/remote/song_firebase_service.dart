import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/common/error_handling/data_state.dart';
import 'package:spotify/features/home/data/model/song_model.dart';
import 'package:spotify/features/home/domain/entities/song_entities.dart';
import 'package:spotify/features/home/domain/usecase/favorite_song_use_case.dart';
import 'package:spotify/locator.dart';

abstract class SongFirebaseService {
  Future <dynamic> getNewsSongs();
  Future <dynamic> addOrRemoveFavoriteSongs(String songId);
  Future <dynamic> isFavoriteSong(String songId);
  Future <dynamic> getUserFavoriteSongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future getNewsSongs() async{
    List<SongEntities> songs = [];
    var data = await firebaseFirestore.collection('songs')
      .orderBy('ReleaseDate',descending: true)
      .get();
    for (var item in data.docs){
      SongModel song = SongModel.fromJson(item.data());
      DataState isFavorite = await locator<IsFavoriteSongUseCae>().call(param: item.reference.id,);
      song.isFavorite = isFavorite.data;
      song.songId = item.reference.id;
      songs.add(song);
    }
    return songs;
  }

  @override
  Future addOrRemoveFavoriteSongs(String songId) async{
    late bool isFavorite = false;
    var user = firebaseAuth.currentUser;
    String uId = user!.uid;
    QuerySnapshot favoriteSong = await firebaseFirestore.collection('users')
      .doc(uId)
      .collection('Favorites')
      .where('songId',isEqualTo: songId)
      .get();
    if(favoriteSong.docs.isNotEmpty){
      await favoriteSong.docs.first.reference.delete();
      isFavorite = false;
    }else{
      firebaseFirestore.collection('users')
        .doc(uId)
        .collection('Favorites')
        .add(
         {
           'songId' : songId,
           'addDate': Timestamp.now()
         }
      );
      isFavorite = true;
    }
    return isFavorite;
  }


  @override
  Future isFavoriteSong(String songId) async{
    var user = firebaseAuth.currentUser;
    String uId = user!.uid;
    QuerySnapshot favoriteSong = await firebaseFirestore.collection('users')
      .doc(uId)
      .collection('Favorites')
      .where('songId',isEqualTo: songId)
      .get();
    if(favoriteSong.docs.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  @override
  Future getUserFavoriteSongs() async{
    var user = firebaseAuth.currentUser;
    List<SongEntities> favoriteSongs = [];
    String uId = user!.uid;
    QuerySnapshot favoriteSongUser = await firebaseFirestore.collection('users')
        .doc(uId)
        .collection('Favorites')
        .get();

    for(var item in favoriteSongUser.docs){
      String songId = item['songId'];
      var song  = await firebaseFirestore.collection('songs').doc(songId).get();
      SongModel songModel = SongModel.fromJson(song.data()!);
      songModel.isFavorite = true;
      songModel.songId = songId;
      favoriteSongs.add(songModel);
    }
      return favoriteSongs;
    }
  }