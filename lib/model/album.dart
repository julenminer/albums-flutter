import 'package:albums/model/song.dart';
import 'package:uuid/uuid.dart';

class Album {
  final String id;
  final String title;
  final String artist;
  final String coverUrl;
  final String year;
  final String genre;
  final List<Song> songs;
  bool favorite = false;

  Album(this.id, this.title, this.artist, this.coverUrl, this.year, this.genre, this.songs);

  Album.fromJson(Map<String, dynamic> json)
      : id = Uuid().v4(),
        title = json['title'],
        artist = json['artist'],
        coverUrl = json['coverUrl'],
        year = json['releaseYear'],
        genre = json['genre'],
        songs = (json['songs'] as List<dynamic>)
            .map((song) => Song.fromJson(song))
            .toList();
}
