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
            : (txt == "pause"
                ? Icons.pause_circle_filled
                : FontAwesomeIcons.stopCircle),
        color: txt == "play" ? Colors.green : Colors.yellow,
        size: txt == "play" ? 80.0 : 60.0,
      ),
    );
  }

  Widget slider() {
    return Slider(
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        activeColor: Colors.pinkAccent,
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
///////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    var blueColor=Color(0xFF090e42);
    var pinkColor= Color(0xFFff6b80);
    return Scaffold(
      backgroundColor: blueColor,
      body: ListView(
        children: <Widget>[
        
          Container(
            height: 350.0,
            color: Colors.red,
            child: Stack(
              children: <Widget>[
              


                    Container(
                  height: 350.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: ExactAssetImage('assets/${songs[a]['img']}',), fit: BoxFit.cover,),
                    ),),



                Container(
                  height: 350.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [blueColor.withOpacity(0.3), blueColor], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    ),),
                
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15.0,),
                       Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                        
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Icon(Icons.arrow_drop_down, color: Colors.white, size: 30.0,)),
                    Column(
                      children: <Widget>[
  Text("PLAYLIST", style: TextStyle(color: Colors.yellow.withOpacity(0.7), fontSize: 25.0),),
                      Text("${songs[a]['name']}"),


                    
                      ],
                    ),
                    Icon(Icons.playlist_add, color: Colors.white, size: 30.0,),

                    
                  ],),
                  Spacer(),
                  Text("${songs[a]['name1']}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32.0) ,),
                  
                    ],
                  ),
                ),

               



              ],
            ),
          ),
          slider(),
          ListPlay(),
         Row(
         children: <Widget>[
           Spacer(),
RaisedButton(onPressed:() => onbuttonClick(),
                    child: Text("back to menu"),
                    elevation: 10.0,
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),),
                    ),
                    Spacer(),
         ],),
            
          
          
          
                  ],
                ),
              );
            }
/////////////////////////////////////////////////////////////////////
          
            next() {
              setState(() {
                advancedPlayer.stop();
                if (a > songs.length-2) {
                  a = 0;
                } else {
                  a = a + 1;
                }
              audioCache.play(songs[a]['name']);
              });
            }
            previous(){
              setState(() {
                advancedPlayer.stop();
                 if (a < 1) {
                  a = songs.length-1;
                } else {
                  a = a - 1;
                }
                
                audioCache.play(songs[a]['name']);
              });
            }
            Widget ListPlay(){
              return  ListTile(
                      onTap: null,
                      title: Container(
                        width: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            
                            ///////bbuuttoonnss
                            btn('pause', () => advancedPlayer.pause()),
                            btn('play', () {audioCache.play(songs[a]['name']);  
                            widget.check1(widget.index);
                            dur = _duration.inSeconds.toDouble() / 60;
                              m = (dur).toStringAsFixed(2);
                              print(m);
                            }),
                            btn('stop', () {
                              advancedPlayer.stop();
                            }),
                            ///////////////buttons
                          ],
                        ),
                      ),
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                         
                          InkWell(
                            child: Icon(
                              Icons.skip_previous,
                              size: 40.0,
                            ),
                            onTap: () => previous(),
                          ),
                          
                        ],
                      ),
                      trailing: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                        children: <Widget>[
                         
                          InkWell(
                            child: Icon(
                              Icons.skip_next,
                              size: 40.0,
                            ),
                            onTap: () => next(),
                          ),
                        ],
                      ),
                    );
            }
          
            onbuttonClick() {
              advancedPlayer.pause();
              Navigator.pop(context);
            }
}
