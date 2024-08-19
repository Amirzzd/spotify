import 'package:spotify/features/home/domain/entities/song_entities.dart';

class SongModel extends SongEntities{

  SongModel({
    super.artist,
    super.duration,
    super.title,
    super.cover,
    super.releaseDate,
    super.song,
    super.isFavorite,
    super.songId
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
       artist : json['Artist'],
       duration : json['Duration'],
       title : json['Title'],
       releaseDate: json['ReleaseDate'],
       song: json['song'],
       cover: json['cover'],
    );
  }
}