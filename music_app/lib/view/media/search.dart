import 'package:flutter/material.dart';
import 'file:///D:/SM9/SWD391/music_app/lib/repositories/api.dart';

import 'package:music_app/model/media.dart';
import 'package:music_app/model/repo.dart';
import 'file:///D:/SM9/SWD391/music_app/lib/view/media/search_list.dart';
import 'package:music_app/view/media/components/item.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchState();
}

// class _SearchState extends State<Search> {
//   List<Repo> _repos = List();
//
//   bool _isFetching = false;
//   String _error;
//
//   @override
//   void initState() {
//     super.initState();
//     loadTrendingRepos();
//   }
//
//   void loadTrendingRepos() async {
//     setState(() {
//       _isFetching = true;
//       _error = null;
//     });
//
//     final repos = await Api.getTrendingRepositories();
//     setState(() {
//       _isFetching = false;
//       if (repos != null) {
//         this._repos = repos;
//       } else {
//         _error = 'Error fetching repos';
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Container(
//             margin: EdgeInsets.only(top: 4.0),
//             child: Column(
//               children: <Widget>[
//                 Text('Github Repos',
//                     style: Theme
//                         .of(context)
//                         .textTheme
//                         .headline
//                         .apply(color: Colors.white)),
//                 Text('Trending',
//                     style: Theme
//                         .of(context)
//                         .textTheme
//                         .subhead
//                         .apply(color: Colors.white))
//               ],
//             )),
//         centerTitle: true,
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SearchList(),
//                     ));
//               }),
//         ],
//       ),
//       body: buildBody(context),
//     );
//   }
//
//   Widget buildBody(BuildContext context) {
//     if (_isFetching) {
//       return Container(
//           alignment: Alignment.center, child: Icon(Icons.timelapse));
//     } else if (_error != null) {
//       return Container(
//           alignment: Alignment.center,
//           child: Text(
//             _error,
//             style: Theme.of(context).textTheme.headline,
//           ));
//     } else {
//       return ListView.builder(
//           padding: EdgeInsets.symmetric(vertical: 8.0),
//           itemCount: _repos.length,
//           itemBuilder: (BuildContext context, int index) {
//             return GithubItem(_repos[index]);
//           });
//     }
//   }
// }

class _SearchState extends State<Search> {
  List<Media> _repos = List();

  bool _isFetching = false;
  String _error;

  @override
  void initState() {
    super.initState();
    loadTrendingRepos();
  }

  void loadTrendingRepos() async {
    setState(() {
      _isFetching = true;
      _error = null;
    });

    final repos = await Api.getMedia();
    setState(() {
      _isFetching = false;
      if (repos != null) {
        this._repos = repos;
      } else {
        _error = 'Error fetching media';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff100a20),
        title: Container(
            margin: EdgeInsets.only(top: 4.0),
            child: Column(
              children: <Widget>[
                Text('Media List',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline
                        .apply(color: Colors.white)),
                Text('Trending',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead
                        .apply(color: Colors.white))
              ],
            )),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchList(),
                    ));
              }),
        ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    if (_isFetching) {
      return Container(
          alignment: Alignment.center, child: Icon(Icons.timelapse));
    } else if (_error != null) {
      return Container(
          alignment: Alignment.center,
          child: Text(
            _error,
            style: Theme.of(context).textTheme.headline,
          ));
    } else {
      return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _repos.length,
          itemBuilder: (BuildContext context, int index) {
            return GithubItem(_repos[index]);
          });
    }
  }
}