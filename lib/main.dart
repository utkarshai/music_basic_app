import 'package:flutter/material.dart';
import 'package:music_app/song_list.dart';
import 'package:music_app/song_play.dart';

typedef void OnError(Exception exception);

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int cur=2000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Center(
          child: Text("hello"),
        ),
        Container(
          height: 450.0,
          child: new ListView.builder(
              itemCount: songs.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Divider(),

                    //Text(song[index]['name']),
                    ListTile(
                      title: Text(
                        songs[index]['name'],
                        style: TextStyle(color: Colors.lightGreen),
                      ),
                      trailing: songs[index]['check']==1?Icon(Icons.local_play):null,
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'assets/${songs[index]['img']}',
                            height: 60.0,
                            width: 60.0,
                          )),
                          onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> PlayPage(check, index)),
                    ),
                    ),],
                );
              }),
        ),
        Column(
          children: <Widget>[
            Text("Now Playing"),
            SizedBox(height: 20.0,),
            cur!=2000? _a(cur):Container(child: Text("nothing played"),),
          ],
        )
      ],
    
    ));
  }

  check(int index) {
    setState(() {
     cur=index;
      // songs[index]['check'] = 1;
      // play=0;
    });
    print(songs[index]['check']);
   
  }
  Widget _a(int cur){
    return ListTile(
                      title: Text(
                        songs[cur]['name'],
                        style: TextStyle(color: Colors.yellow),
                      ),
                      trailing: InkWell(child: Icon(Icons.play_arrow),
                      onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> PlayPage(check, cur)),),),
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
