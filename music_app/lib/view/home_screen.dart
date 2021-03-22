import 'dart:ui';

// import 'package:book_project/models/DatabaseHelper.dart';
// import 'package:book_project/screens/add_book_screen.dart';
// import 'package:book_project/screens/search_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'file:///D:/SM9/SWD391/music_app/lib/repositories/DatabaseHelper.dart';
import 'file:///D:/SM9/SWD391/music_app/lib/repositories/sign_in_google.dart';

import 'package:music_app/view/authen_screen.dart';
import 'package:music_app/view/media/search.dart';
import 'package:music_app/view/media/search_list.dart';
import 'package:music_app/view/search_screen.dart';
import 'file:///D:/SM9/SWD391/music_app/lib/view/album_details_screen.dart';
import 'file:///D:/SM9/SWD391/music_app/lib/view/media/search.dart';

import 'package:music_app/view/user_profile_screen.dart';

import 'package:music_app/widget/bottom_loader.dart';
import 'package:music_app/widget/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../size_config.dart';

// import 'book_detail_screen.dart';
// import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final Color primary = Colors.black54;
  final Color active = Colors.white;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  final TextEditingController _searchcontroller = new TextEditingController();

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_onScroll);
    // _postBloc = context.read<AlbumBloc>();
  }

  // void _onScroll() {
  //   if (_isBottom) _postBloc.add(PostFetched());
  // }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  // _save(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'token';
  //   final value = token;
  //   prefs.setString(key, value);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff100a20),
      drawer: _buildDrawer(),
      key: _key,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          child: Row(
            children: <Widget>[
              Text(
                "MUSIC",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: darkPrimaryColor),
              ),
              Column(
                children: <Widget>[
                  Text(
                    "on",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: darkPrimaryColor),
                  ),
                  Container(
                    height: 3,
                    width: 15,
                    color: Colors.white,
                  )
                ],
              ),
              Text(
                "DEMAND",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: darkPrimaryColor),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new SearchList(),
                ));
              },
              icon: Icon(
                Icons.search,
                color: darkPrimaryColor,
                size: 30,
              ))
        ],
      ),
      body: FutureBuilder<List>(
        future: databaseHelper.getAlbumData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(list: snapshot.data)
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  _buildDrawer() {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: active,
                      ),
                      onPressed: () {
                        signOutGoogle();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) {
                          return AuthenScreen();
                        }), ModalRoute.withName('/'));
                      },
                    ),
                  ),
                  SizedBox(height: 5.0),
                  SizedBox(height: 30.0),
                  _buildProfile(Icons.person, "Your profile"),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: active,
    );
  }

  Widget _buildProfile(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        IconButton(
          icon: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return UserProfileScreen();
                },
              ),
            );
          },
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ItemList extends StatelessWidget {
  List list;
  static List<String> imgList = [
    'assets/images/albumcover/album1.png',
    'assets/images/albumcover/album2.png',
    'assets/images/albumcover/album3.png',
    'assets/images/albumcover/album4.png',
    'assets/images/albumcover/album5.png',
    'assets/images/albumcover/album1.png',
    'assets/images/albumcover/album2.png',
    'assets/images/albumcover/album3.png',
  ];
  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 230,
                    width: 155,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: AssetImage(item), fit: BoxFit.cover)),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      height: 50,
                      width: 50,
                      alignment: Alignment.bottomRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.grey.shade200.withOpacity(0.5),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ))
      .toList();

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
              SizedBox(
                height: 20,
              ),
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 230,
                    viewportFraction: 0.44,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                  ),
                  items: imageSliders,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "   Best Albums",
                style: TextStyle(
                    fontFamily: 'Avenir',
                    color: darkPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: list == null ? 0 : list.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return new Container(
                          padding: const EdgeInsets.all(10.0),
                          child: new GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new AlbumDetailsScreen(
                                        list: list,
                                        index: i,
                                      )),
                            ),
                            child: InkWell(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Hero(
                                      tag: list[i]['id'],
                                      child: Container(
                                        width: 90,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    list[i]['image']),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 260,
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            list[i]['name'],
                                            style: TextStyle(
                                              color: darkPrimaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Avenir',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          list[i]['producer'],
                                          style: TextStyle(
                                              fontFamily: 'Avenir',
                                              color: darkPrimaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: 260,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                '${list[i]['doi']} ',
                                                style: TextStyle(
                                                    color: darkPrimaryColor,
                                                    fontSize: 14,
                                                    fontFamily: 'Avenir',
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
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
