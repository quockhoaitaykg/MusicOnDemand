
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_app/model/media.dart';

import 'dart:convert' show json, utf8;
import 'dart:io';
import 'dart:async';

import 'package:music_app/model/repo.dart';

class Api {
  static final HttpClient _httpClient = HttpClient();
  static final String _url = "api.github.com";
  static final String _url2 = "music-env.eba-9xc8in5w.ap-southeast-1.elasticbeanstalk.com";

  static Future<List<Repo>> getRepositoriesWithSearchQuery(String query) async {
    final uri = Uri.https(_url, '/search/repositories', {
      'q': query,
      'sort': 'stars',
      'order': 'desc',
      'page': '0',
      'per_page': '25'
    });

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }
    if (jsonResponse['errors'] != null) {
      return null;
    }
    if (jsonResponse['items'] == null) {
      return List();
    }

    return Repo.mapJSONStringToList(jsonResponse['items']);
  }
  static Future<List<Media>> getMediaSearchQuery(String query) async {
    final uri = Uri.http(_url2, '/medium/search', {
      'name': query,
      'page': '1',
      'rowperpage': '8'
    });

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }
    if (jsonResponse['errors'] != null) {
      return null;
    }
    if (jsonResponse['data'] == null) {
      return List();
    }
    print("uri = "+ uri.toString());
    return Media.mapJSONStringToList(jsonResponse['data']);
  }

  static Future<List<Media>> getMedia() async {

    final uri = Uri.http(_url2, '/medium/search', {
      'name': 'a',
      'page': '1',
      'rowperpage': '8'
    });
    print("uri = "+ uri.toString());

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }
    if (jsonResponse['errors'] != null) {
      return null;
    }
    if (jsonResponse['data'] == null) {
      return List();
    }

    return Media.mapJSONStringToList(jsonResponse['data']);
  }


  static Future<List<Repo>> getTrendingRepositories() async {
    final lastWeek = DateTime.now().subtract(Duration(days: 7));
    final formattedDate = formatDate(lastWeek, [yyyy, '-', mm, '-', dd]);

    final uri = Uri.https(_url, '/search/repositories', {
      'q': 'created:>$formattedDate',
      'sort': 'stars',
      'order': 'desc',
      'page': '0',
      'per_page': '25'
    });

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }
    if (jsonResponse['errors'] != null) {
      return null;
    }
    if (jsonResponse['items'] == null) {
      return List();
    }

    return Repo.mapJSONStringToList(jsonResponse['items']);
  }


  static Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.OK) {
        return null;
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();
      return json.decode(responseBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }


}
