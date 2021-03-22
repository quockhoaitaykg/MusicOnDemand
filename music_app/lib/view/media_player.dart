import 'package:flutter/material.dart';
import 'package:music_app/widget/albumart.dart';
import 'package:music_app/widget/navbar.dart';
import 'package:provider/provider.dart';
import 'package:music_app/widget/colors.dart';
import 'package:music_app/model/myaudio.dart';
import 'package:music_app/widget/playerControls.dart';

class MediaPlayer extends StatefulWidget {
  static const String id = 'media_player';
  @override
  _MediaPlayerState createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  double sliderValue = 2;

  Map audioData = {
    'image':
        'https://thegrowingdeveloper.org/thumbs/1000x1000r/audios/quiet-time-photo.jpg',
    'url':
        'https://thegrowingdeveloper.org/files/audios/quiet-time.mp3?b4869097e4'
  };

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          NavigationBar(),
          Container(
            margin: EdgeInsets.only(left: 60),
            height: height / 3.0,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return AlbumArt();
              },
              itemCount: 1,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Text(
            'Gidget',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: darkPrimaryColor),
          ),
          Text(
            'The Free Nationals',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: darkPrimaryColor),
          ),
          Column(
            children: [
              SliderTheme(
                data: SliderThemeData(
                    trackHeight: 5,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5)),
                child: Consumer<MyAudio>(
                  builder: (_, myAudioModel, child) => Slider(
                    value: myAudioModel.position == null
                        ? 0
                        : myAudioModel.position.inMilliseconds.toDouble(),
                    activeColor: darkPrimaryColor,
                    inactiveColor: darkPrimaryColor.withOpacity(0.3),
                    onChanged: (value) {
                      myAudioModel
                          .seekAudio(Duration(milliseconds: value.toInt()));
                    },
                    min: 0,
                    max: myAudioModel.totalDuration == null
                        ? 20
                        : myAudioModel.totalDuration.inMilliseconds.toDouble(),
                  ),
                ),
              ),
            ],
          ),
          PlayerControls(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
