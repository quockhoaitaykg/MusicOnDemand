import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/model/myaudio.dart';

import 'package:music_app/view/authen_screen.dart';
import 'file:///D:/SM9/SWD391/music_app/lib/view/album_details_screen.dart';
import 'package:music_app/view/home_screen.dart';
import 'package:music_app/view/media_player.dart';
import 'package:music_app/view/search_screen.dart';

import 'package:music_app/view/update_profile_screen.dart';
import 'package:music_app/view/user_profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      // return MaterialApp(
      //   title: 'Music App',
      //   debugShowCheckedModeBanner: false,
      //   theme: ThemeData(
      //     visualDensity: VisualDensity.adaptivePlatformDensity,
      //   ),
      //
      //   initialRoute: AuthenScreen  .id,
      //   routes: {
      //     AuthenScreen.id: (context) => AuthenScreen(),
      //     HomeScreen.id: (context) => HomeScreen(),
      //     // UserProfileScreen.id: (context) => UserProfileScreen(),
      //     UpdateProfileScreen.id: (context) => UpdateProfileScreen(),
      //     SearchScreen.id:(context) => SearchScreen(),
      //     AlbumDetailsScreen.id: (context) => AlbumDetailsScreen(),
      //     MediaPlayer.id:(context) => MediaPlayer(),
      //   },
      //
      // );

    return ChangeNotifierProvider(
      create: (context) => MyAudio(),
      child: MaterialApp(title: 'Flutter Demo', home: AuthenScreen()),
    );


  }
}



