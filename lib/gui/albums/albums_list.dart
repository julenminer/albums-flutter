import 'package:albums/model/album.dart';
import 'package:albums/provider/albums_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'album_page.dart';

class AlbumsList extends StatelessWidget {
  const AlbumsList({Key? key, required this.albums}) : super(key: key);

  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    final albumsProvider = Provider.of<AlbumsProvider>(context);

    return Container(
        child: Scrollbar(
      child: ListView.builder(
          itemCount: albums.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Hero(
                  tag: albums[index].id,
                  child: Image.network(albums[index].coverUrl)),
              title: Text(albums[index].title),
              subtitle: Text(albums[index].artist),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AlbumPage(album: albums[index])),
                );
              },
              trailing: IconButton(
                  onPressed: () {
                    albumsProvider.toggleFavorite(albums[index].id);
                  },
                  icon: Hero(
                    tag: albums[index].id + "fav",
                    child: Icon(albums[index].favorite
                        ? Icons.star_rounded
                        : Icons.star_border_rounded),
                  )),
            );
          }),
    ));
  }
}
