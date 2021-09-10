import 'package:albums/gui/home.dart';
import 'package:albums/provider/albums_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AlbumsProvider>.value(value: AlbumsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Albums',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage()
      ),
    );
  }
}