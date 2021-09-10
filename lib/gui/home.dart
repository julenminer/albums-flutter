import 'package:albums/gui/albums/albums_list.dart';
import 'package:albums/provider/albums_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedPageIndex;

  @override
  void initState() {
    _selectedPageIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final albumsProvider = Provider.of<AlbumsProvider>(context);

    if (albumsProvider.albums == null) {
      albumsProvider.init();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Albums"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.library_music_outlined), label: "Library"),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border_rounded), label: "Favorites")
        ],
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            if (mounted) {
              _selectedPageIndex = index;
            }
          });
        },
      ),
      body: albumsProvider.albums == null
          ? LoadingPage()
          : AlbumsList(
              albums: _selectedPageIndex == 0
                  ? albumsProvider.albums
                  : albumsProvider.favoriteAlbums),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
