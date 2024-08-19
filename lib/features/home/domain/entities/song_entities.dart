import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntities {
  final String? artist;
  final Timestamp? releaseDate;
  final double? duration;
  final String? title;
  final String? cover;
  final String? song;
  bool? isFavorite;
  String? songId;

  SongEntities({this.artist, this.duration, this.title,this.cover,this.releaseDate,this.song,this.isFavorite,this.songId});
}