import 'package:flutter/material.dart';
import 'package:music_app/model/media.dart';
import 'package:music_app/model/repo.dart';
import 'package:music_app/repositories/DatabaseHelper.dart';
import 'package:music_app/view/media_player.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubItem extends StatelessWidget {
  // final Repo repo;
  // GithubItem(this.repo);

  final Media media;
  GithubItem(this.media);
  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     child: InkWell(
  //         onTap: () {
  //           _launchURL(repo.htmlUrl);
  //         },
  //         highlightColor: Colors.lightBlueAccent,
  //         splashColor: Colors.red,
  //         child: Container(
  //           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //           child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Text((repo.name != null) ? repo.name : '-',
  //                     style: Theme.of(context).textTheme.subhead),
  //                 Padding(
  //                   padding: EdgeInsets.only(top: 4.0),
  //                   child: Text(
  //                       repo.description != null
  //                           ? repo.description
  //                           : 'No desription',
  //                       style: Theme.of(context).textTheme.body1),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(top: 8.0),
  //                   child: Row(
  //                     children: <Widget>[
  //                       Expanded(
  //                           child: Text((repo.owner != null) ? repo.owner : '',
  //                               textAlign: TextAlign.start,
  //                               style: Theme.of(context).textTheme.caption)),
  //                       Expanded(
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: <Widget>[
  //                             Icon(
  //                               Icons.star,
  //                               color: Colors.deepOrange,
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.only(top: 4.0),
  //                               child: Text(
  //                                   (repo.watchersCount != null)
  //                                       ? '${repo.watchersCount} '
  //                                       : '0 ',
  //                                   textAlign: TextAlign.center,
  //                                   style: Theme.of(context).textTheme.caption),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       Expanded(
  //                           child: Text(
  //                               (repo.language != null) ? repo.language : '',
  //                               textAlign: TextAlign.end,
  //                               style: Theme.of(context).textTheme.caption)),
  //                     ],
  //                   ),
  //                 ),
  //               ]),
  //         )),
  //   );
  // }
  DatabaseHelper databaseHelper = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () {
            databaseHelper.fetchMedia(media.id);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return MediaPlayer();
                },
              ),
            );
          },
          highlightColor: Colors.lightBlueAccent,
          splashColor: Colors.red,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.music_note_outlined,
                        color: Colors.deepPurpleAccent,
                      ),
                      Text((media.name != null) ? media.name : '-',
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent,
                            fontSize: 20.0,
                          )),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle_sharp,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 5),
                        Text(media.musician != null ? media.musician : 'V.A',
                            style: Theme.of(context).textTheme.body1),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text((media.doi != null) ? media.doi : '',
                                textAlign: TextAlign.end,
                                style: Theme.of(context).textTheme.caption)),
                      ],
                    ),
                  ),
                ]),
          )),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
