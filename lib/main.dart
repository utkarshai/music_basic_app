import 'package:flutter/material.dart';
import 'package:music_app/song_list.dart';
import 'package:music_app/song_play.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/suggestion.dart';
typedef void OnError(Exception exception);

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  
  int cur = 2000;
List li=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int i=0;
    for(i=0; i<songs.length; i++){
      li.insert(i, songs[i]['name'].toLowerCase());
    }
    print(li);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Music"),
        elevation: 4.0,
        actions: <Widget>[
          InkWell(child: Icon(Icons.search), onTap: (){
            showSearch(
              context: context,
              delegate: DataSearch(li, check),
            );
          },),
        ],

      ),
        body: ListView(
      children: <Widget>[
       Center(child: Text("PlayList", style: TextStyle(fontSize: 30.0),)),
       Divider(
         color: Colors.yellow,
       ),
        Container(
          height: 350.0,
          child: new ListView.builder(
              itemCount: songs.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                   
Card(
  
  child: ListTile(
                      title: Text(
                        songs[index]['name'],
                        style: TextStyle(color: Colors.lightGreen),
                      ),
                      leading: Stack(
                        children: <Widget>[
                          Container(
                            height: 80.0,
                            width: 80.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/${songs[index]['img']}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: 80.0,
                            width: 80.0,
                            child: Icon(
                              Icons.play_circle_filled,
                              color: Colors.white.withOpacity(0.7),
                              size: 42.0,
                            ),
                          ),
                        ],
                      ), //Icon(Icons.more_horiz),
                      trailing: Icon(Icons.more_horiz),
                      // leading: Container(
                      //   height: 80.0,
                      //   width: 80.0,
                      //   child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //       child: Stack(
                      //         children: <Widget>[
                      //
                      //          Icon(Icons.play_circle_outline, ),
                      //         ],
                      //       ),),
                      // ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayPage(check, index)),
                      ),
                    ),
                    elevation: 15.0,
),
                    //Text(song[index]['name']),
                    ////////////////////////////
                     
                  ],
                );
              }),
        ),
        Column(
          children: <Widget>[
            Text("Now Playing"),
            SizedBox(
              height: 20.0,
            ),
            cur != 2000
                ? _a(cur)
                : Container(
                    child: Text("nothing played"),
                  ),
          ],
        )
      ],
    ));
  }

  check(int index) {
    setState(() {
      cur = index;
      // songs[index]['check'] = 1;
      // play=0;
    });
    print(songs[index]['check']);
  }

  Widget _a(int cur) {
    return ListTile(
      title: Text(
        songs[cur]['name'],
        style: TextStyle(color: Colors.yellow),
      ),
      trailing: InkWell(
        child: Icon(Icons.play_arrow),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlayPage(check, cur)),
        ),
      ),
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(
            'assets/${songs[cur]['img']}',
            height: 60.0,
            width: 60.0,
          )),
    );
  }
}
