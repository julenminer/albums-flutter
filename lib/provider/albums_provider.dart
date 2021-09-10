import 'dart:convert';

import 'package:albums/model/album.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AlbumsProvider extends ChangeNotifier {
  List<Album>? _albums;

  init() async {
    _albums = [];
    final String response = await rootBundle.loadString('assets/albums.json');
    List<dynamic> data = await json.decode(response);
    _albums = data.map((album) => Album.fromJson(album)).toList();
    notifyListeners();
  }

  get albums => _albums;
  get favoriteAlbums => _albums?.where((element) => element.favorite).toList();

  void toggleFavorite(String id) {
    if(_albums != null) {
      var index = _albums!.indexWhere((element) => element.id == id);
      _albums![index].favorite = !_albums![index].favorite;
      notifyListeners();
    }
  }
}