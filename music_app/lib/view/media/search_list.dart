import 'package:flutter/material.dart';
import 'file:///D:/SM9/SWD391/music_app/lib/repositories/api.dart';
import 'package:music_app/model/media.dart';

import 'dart:async';

import 'package:music_app/model/repo.dart';
import 'package:music_app/view/media/components/item.dart';
import 'package:music_app/widget/colors.dart';

class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<SearchList> {
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;
  String _error;
  List<Repo> _results = List();
  List<Media> _results2 = List();

  Timer debounceTimer;

  _SearchState() {
    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 500), () {
        if (this.mounted) {
          performSearch(_searchQuery.text);
        }
      });
    });
  }

  void performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _error = null;
        // _results = List();
        _results2 = List();
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
      // _results = List();
      _results2 = List();
    });

    // final repos = await Api.getRepositoriesWithSearchQuery(query);
    final media = await Api.getMediaSearchQuery(query);
    if (this._searchQuery.text == query && this.mounted) {
      // setState(() {
      //   _isSearching = false;
      //   if (repos != null) {
      //     _results = repos;
      //
      //   } else {
      //     _error = 'Error searching repos';
      //   }
      // });

      setState(() {
        _isSearching = false;
        if (media != null) {
          _results2 = media;
        } else {
          _error = 'Error searching media';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: AppBar(
          backgroundColor: Color(0xff100a20),
          centerTitle: true,
          title: TextField(
            autofocus: true,
            controller: _searchQuery,
            style: TextStyle(color: darkPrimaryColor),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(end: 16.0),
                    child: Icon(
                      Icons.search,
                      color: darkPrimaryColor,
                    )),
                hintText: "  Search media...",
                hintStyle: TextStyle(color: darkPrimaryColor)),
          ),
        ),
        body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    if (_isSearching) {
      return CenterTitle('Searching Media...');
    } else if (_error != null) {
      return CenterTitle(_error);
    } else if (_searchQuery.text.isEmpty) {
      return CenterTitle('Begin Search by typing on search bar');
    } else {
      return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _results2.length,
          itemBuilder: (BuildContext context, int index) {
            return GithubItem(_results2[index]);
          });
    }
  }
}

class CenterTitle extends StatelessWidget {
  final String title;

  CenterTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ));
  }
}
