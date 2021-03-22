import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'file:///D:/SM9/SWD391/music_app/lib/repositories/DatabaseHelper.dart';

import 'package:music_app/widget/colors.dart';
import 'package:music_app/widget/constants.dart';

import 'package:music_app/components/default_button.dart';

import 'package:music_app/size_config.dart';

class AlbumDetailsScreen extends StatefulWidget {
  static const String id = 'album_detail_screen';
  List list;
  int index;

  AlbumDetailsScreen({this.index, this.list});
  @override
  _AlbumDetailsScreenState createState() => _AlbumDetailsScreenState();
}

// class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       backgroundColor: Color(0xFFF5F6F9),
//
//       body: SafeArea(
//         child: Container(
//             child: Column(
//               children:<Widget> [
//                 SizedBox(
//                   child: AspectRatio(
//                     aspectRatio: 1,
//                     child: Hero(
//                       tag: widget.list[widget.index]['id'],
//                       child: Image.network(
//                         widget.list[widget.index]['image'],
//                         height: 350,
//                         width: 500,
//                         fit: BoxFit.fitWidth,
//                       ),
//                     ),
//                   ),
//                 ),
//                 TopRoundedContainer(
//                   color: Colors.white,
//                   child: Column(
//                     children: [
//                       //Album description
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding:
//                             EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//                             child: Text(
//                               widget.list[widget.index]['imageUrl'],
//                               style: Theme.of(context).textTheme.headline6,
//                             ),
//                           ),
//
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: getProportionateScreenWidth(20),
//                               right: getProportionateScreenWidth(64),
//                             ),
//                             child: Text(
//                               widget.list[widget.index]['producer'],
//                               maxLines: 3,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: getProportionateScreenWidth(20),
//                               vertical: 10,
//                             ),
//                             child: GestureDetector(
//                               onTap: () {},
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     "See More Detail",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w600, color: kPrimaryColor),
//                                   ),
//                                   SizedBox(width: 5),
//                                   Icon(
//                                     Icons.arrow_forward_ios,
//                                     size: 12,
//                                     color: kPrimaryColor,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       TopRoundedContainer(
//                         color: Color(0xFFF6F7F9),
//                         child: Column(
//                           children: [
//                             // ColorDots(product: product),
//                             TopRoundedContainer(
//                               color: Colors.white,
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                   left: SizeConfig.screenWidth * 0.15,
//                                   right: SizeConfig.screenWidth * 0.15,
//                                   bottom: getProportionateScreenWidth(40),
//                                   top: getProportionateScreenWidth(15),
//                                 ),
//                                 child: DefaultButton(
//                                   text: "Add To Cart",
//                                   press: () {},
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//
//         ),
//       ),
//
//       );
//   }
// }

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  Widget _buildUpdateBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 150,
      child: RaisedButton(
        elevation: 5.0,
        // onPressed: () =>
        //     Navigator.of(context).push(
        //         new MaterialPageRoute(
        //           builder: (BuildContext context) =>
        //           new UpdateScreen(list: widget.list, index: widget.index),
        //         )
        //     ),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'UPDATE',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Xóa thành công'),
            content: new Text('Ấn OK để quay lại màn hình chính'),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(
                  'OK',
                ),
                // onPressed: () {
                //   Navigator.pushNamed(context, HomeScreen.id);
                // },
              ),
            ],
          );
        });
  }

  Widget _buildDeleteBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 150,
      child: RaisedButton(
        elevation: 5.0,
        // onPressed: () {
        //   databaseHelper.deleteData("${widget.list[widget.index]['id']}");
        //   _showSuccessDialog();
        // },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.redAccent,
        child: Text(
          'DELETE',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          _buildDeleteBtn(),
          SizedBox(width: 60),
          _buildUpdateBtn(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff100a20),
      body: SafeArea(
          child: Container(
        color: Color(0xff100a20),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.network(
                  "${widget.list[widget.index]['image']}",
                  height: 350,
                  width: 500,
                  fit: BoxFit.fitWidth,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.07),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container())),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: darkPrimaryColor,
                              size: 40,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            })),
                  ],
                ),
                Positioned(
                    bottom: 10,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    )),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Album:',
                              style: TextStyle(
                                  color: darkPrimaryColor,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Avenir',
                                  fontSize: 17),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 260,
                            padding: EdgeInsets.all(5),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Text(
                                '${widget.list[widget.index]['name']}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: darkPrimaryColor,
                                    fontSize: 17,
                                    fontFamily: 'Avenir',
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Producer:',
                              style: TextStyle(
                                  color: darkPrimaryColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${widget.list[widget.index]['producer']}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: darkPrimaryColor,
                                  fontSize: 17,
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Time:',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: darkPrimaryColor,
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${widget.list[widget.index]['time']['totalSeconds']} seconds',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: darkPrimaryColor,
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Doi:',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: darkPrimaryColor,
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${widget.list[widget.index]['doi']}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: darkPrimaryColor,
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
