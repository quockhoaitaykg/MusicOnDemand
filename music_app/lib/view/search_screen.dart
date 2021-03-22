

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/SM9/SWD391/music_app/lib/repositories/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchScreen extends StatefulWidget {
  static String id = 'search_screen';
  SearchScreen({Key key , this.title}) : super(key : key);
  final String title;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List list;


  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List',
      home: Scaffold(

          appBar: AppBar(

            backgroundColor:Color(0xff100a20),

            title: Text('Photo list'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _save('0');
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new SearchScreen(),
                  ));
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  _save('0');
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.add),
            backgroundColor: Colors.blue[800],
            // onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            //   builder: (BuildContext context) => new AddBookSceen(),
            // )),
          ),
          body: new FutureBuilder<List>(
            future: databaseHelper.getActorData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new ItemList(list: snapshot.data)
                  : new Center(
                child: new CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}

class ItemList extends StatelessWidget {
  List list;


  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff100a20),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20,),
              Expanded(child: ListView.builder(
                  itemCount: list == null ? 0 : list.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return new Container(
                      padding: const EdgeInsets.all(10.0),
                      child: new GestureDetector(
                        // onTap: () => Navigator.of(context).push(
                        //   new MaterialPageRoute(
                        //       builder: (BuildContext context) =>
                        //       new BookDetailScreen(
                        //         list: list,
                        //         index: i,
                        //       )),
                        // ),
                        child: InkWell(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Hero(
                                  tag: list[i]['albumId'],
                                  child: Container(
                                    width: 70,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(7)),
                                        image: DecorationImage(
                                            image: NetworkImage(list[i]['url']),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 260,
                                      padding: EdgeInsets.all(2),
                                      child: Text(list[i]['title'],style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(list[i]['thumbnailUrl'], style: TextStyle(
                                        fontFamily: 'montserrat',
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                    ),),
                                    SizedBox(height: 10,),
                                    Container(
                                      width: 250,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[

                                          Row(
                                            children: <Widget>[
                                              Text('${list[i]['id']}', style: TextStyle(

                                                  color: Colors.yellow,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                              Row(
                                                children: <Widget>[
                                                  Text("3.9", style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500
                                                  ),),
                                                  Text("(4.9)", style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w300
                                                  ),),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }))

            ],
          ),
        ),
      ),
    );
  }
}


