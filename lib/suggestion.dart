import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/song_list.dart';
import 'package:music_app/song_play.dart';
class DataSearch extends SearchDelegate<String>{
   List li;
  final Function check;
  DataSearch(this.li, this.check);
  List mi=[
    "baarish.mp3",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
   return [
     IconButton(
       icon: Icon(Icons.clear),
       onPressed: (){
         query="";
       },
     ),
   ];
  }

  

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
  
   final suggestionList=query.isEmpty?mi:li.where((p) => p.startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemBuilder: (_, index)=> Column(children: <Widget>[
 ListTile(
    leading: Icon(FontAwesomeIcons.music),
    trailing: InkWell(child: Icon(Icons.more_vert), onTap: (){
      AlertDialog(
        actions: <Widget>[
          
        ],
      );
    },),
    onTap: (){
     
     int m=0, i=0;
     for(m=0; m<li.length; m++){
       if(li[m]==suggestionList[index]){
         i=m;
       }
     }
       print(suggestionList[index]);
       print(i);
      Navigator.push(context, MaterialPageRoute(
      builder: (_)=>PlayPage(check,i),
    ));
    showResults(context);},  
    title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0,  query.length),
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
              fontSize: 30.0
            ),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.red, fontSize: 20.0),
              )
            ]
          ),
        ),
  ),

Divider(height: 20.0,),
      ],),
      itemCount: suggestionList.length,
    );
  }
  
}