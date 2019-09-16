import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/song_list.dart';

typedef void OnError(Exception exception);

class PlayPage extends StatefulWidget {
  final int index;
  final Function check1;

  PlayPage(this.check1, this.index);

  @override
  _PlayPageState createState() => new _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  int a;
  var n;
  var dur = 0.0;
  int k = 0;
  var m;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
    a = widget.index;
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  String localFilePath;

  Widget btn(String txt, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Icon(
        txt == "play"
            ? FontAwesomeIcons.playCircle
            : (txt == "pause" ? Icons.pause_circle_filled : FontAwesomeIcons.stopCircle),
        color: txt=="play"?Colors.green:Colors.yellow,
        size: txt=="play"?80.0:60.0,
      ),
    );
  }

  Widget slider() {
    return Slider(
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
            n = value;
            print(n);
          });
        });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
    setState(() {
      n = newDuration;
      print(n);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('audioplayers Example'),
      ),
      body:ListView(
        children: <Widget>[
          Text('Play Local Asset \'audio.mp3\':'),

          slider(),
          ListTile(
            onTap: null,
            title: Container(
              width: 100.0,
              child: Row(
                children: <Widget>[
                  btn('pause', () => advancedPlayer.pause()),
                  btn('play', () {
                    audioCache.play(songs[a]['name']);

                    widget.check1(widget.index);

                    dur = _duration.inSeconds.toDouble() / 60;

                    m = (dur).toStringAsFixed(2);

                    print(m);
                  }),
                  
                  btn('stop', () {
                    advancedPlayer.stop();
                  }),
                ],
              ),
            ),
            leading: Icon(Icons.skip_previous),
            trailing: Icon(Icons.skip_next),
          ),
          // Row(
          //   children: <Widget>[

          //   ],
          // ),

          RaisedButton(
            onPressed: () {
              setState(() {
                advancedPlayer.stop();
                if (a > songs.length) {
                  a = 0;
                } else {
                  a = a + 1;
                }
                audioCache.play(songs[a]['name']);
              });
            },
          )
        ],
      ),
    );
  }
}
