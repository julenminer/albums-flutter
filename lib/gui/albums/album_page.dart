import 'package:albums/model/album.dart';
import 'package:albums/model/song.dart';
import 'package:albums/provider/albums_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key, required this.album}) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    final albumsProvider = Provider.of<AlbumsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
        actions: [
          IconButton(
              onPressed: () {
                albumsProvider.toggleFavorite(album.id);
              },
              icon: Hero(
                tag: album.id + "fav",
                child: Icon(album.favorite
                    ? Icons.star_rounded
                    : Icons.star_border_rounded),
              ))
        ],
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.portrait
              ? Scrollbar(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [_albumInfo(context), _portraitAlbumSongs()])),
              )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(child: _albumInfo(context)),
                    _landscapeAlbumSongs()
                  ],
                );
        },
      ),
    );
  }

  Widget _albumInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 200,
              height: 200,
              child: Hero(tag: album.id, child: Image.network(album.coverUrl))),
          SizedBox(
            width: 8,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  album.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.black),
                ),
                Text(
                  album.artist,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                Text("${album.genre} - ${album.year}",
                    style: Theme.of(context).textTheme.caption)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _portraitAlbumSongs() {
    return Column(
      children: album.songs.map((song) => _songListTile(song)).toList(),
    );
  }

  Widget _landscapeAlbumSongs() {
    return Flexible(
      child: Scrollbar(
        child: ListView.builder(
            itemCount: album.songs.length,
            itemBuilder: (context, index) {
              return _songListTile(album.songs[index]);
            }),
      ),
    );
  }

  Widget _songListTile(Song song) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      leading: Text(song.number.toString()),
      minLeadingWidth: 0,
      title: Text(song.title),
      subtitle: Text(song.length),
    );
  }
}
