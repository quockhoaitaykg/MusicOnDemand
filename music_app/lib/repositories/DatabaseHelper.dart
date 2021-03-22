import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/model/media_profile.dart';
import 'package:music_app/model/user.dart';
import 'file:///D:/SM9/SWD391/music_app/lib/repositories/sign_in_google.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  String serverUrl = "https://jsonplaceholder.typicode.com/photos";
  String serverUrl2 =
      "http://music-env.eba-9xc8in5w.ap-southeast-1.elasticbeanstalk.com";
  var status;
  var token;
  String accessToken;

  loginData(String email, String password) async {
    String myUrl = "$serverUrl/User?";
    String info = "email=" + email + "&password=" + password;
    final response = await http.post(myUrl + info,
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    status = response.body.contains("error");

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  loginData2(String email) async {
    String myUrl = "$serverUrl/Accounts/";
    String info = email;
    final response = await http.post(myUrl + info,
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    status = response.body.contains("error");

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  void addUserData(
      String email,
      String password,
      String address,
      String phone,
      String accountStatus,
      String roleId,
      String name,
      String birthdate) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl/Accounts?";
    String info = "Email=" +
        email +
        "&Password=" +
        password +
        "&Address=" +
        address +
        "&Phone=" +
        phone +
        "&AccountStatus=" +
        accountStatus +
        "&RoleId=" +
        roleId +
        "&Fullname=" +
        name +
        "&Birthday=" +
        birthdate;
    http
        .post(myUrl,
            headers: {
              "content-type": "application/json",
              "accept": "application/json"
            },
            body: jsonEncode(info))
        .then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  vertifyToken() async {
    String tokens = tokenId;
    String myUrl = "$serverUrl2/auths/verifytoken";
    String msg = jsonEncode({"token": "$tokens"});

    final response = await http.post(myUrl,
        headers: {
          'Accept': 'application/json',
          "content-type": "application/json"
        },
        body: msg);
    status = response.body.contains('error');

    var data = json.decode(response.body);
    accessToken = data['data']['accessToken'];
    print('access token is -> $accessToken');

    if (status) {
      print('data : ${data["error"]}');
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    } else {
      print('data : ${data["token"]}');
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
      _save(data["token"]);
    }
  }

  updateUserData(String name, String phone, String dob, String image) async {
    String tokens = tokenId;
    String myUrl1 = "$serverUrl2/auths/verifytoken";
    String msg1 = jsonEncode({"token": "$tokens"});

    final response1 = await http.post(myUrl1,
        headers: {
          'Accept': 'application/json',
          "content-type": "application/json"
        },
        body: msg1);
    status = response1.body.contains('error');

    var data1 = json.decode(response1.body);
    accessToken = data1['data']['accessToken'];

    String myUrl = "$serverUrl2/users";
    String msg = jsonEncode(
        {"name": "$name", "phone": "$phone", "dob": "$dob", "image": "$image"});

    print('access token in update is -> $accessToken');
    print('url =' + myUrl);
    print('msg =' + msg);
    final response = await http.put(myUrl,
        headers: {
          'Accept': 'application/json',
          "content-type": "application/json",
          'x-access-token': '$accessToken'
        },
        body: msg);
    status = response.statusCode;
    var data = json.decode(response.body);
    if (response.body.isNotEmpty) {
      data = json.decode(response.body);
    }

    if (status != 200) {
      print('data : ${data["error"]}');
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    } else {
      print('data : ${data["token"]}');
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
      _save(data["token"]);
    }
  }

  Future<List> getActorData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl";
    http.Response response = await http.get(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    return json.decode(response.body);
  }

  Future<List<Map<String, dynamic>>> getAlbumData() async {
    String tokens = tokenId;
    String myUrl1 = "$serverUrl2/auths/verifytoken";
    String msg1 = jsonEncode({"token": "$tokens"});

    final response1 = await http.post(myUrl1,
        headers: {
          'Accept': 'application/json',
          "content-type": "application/json"
        },
        body: msg1);
    status = response1.body.contains('error');

    var data1 = json.decode(response1.body);
    accessToken = data1['data']['accessToken'];

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl2/albums/getall";
    http.Response response = await http.get(myUrl, headers: {
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $value',
      "content-type": "application/json",
      'x-access-token': '$accessToken'
    });

    return List<Map<String, dynamic>>.from(json.decode(response.body)['data']);
  }

  Future<List<Map<String, dynamic>>> searchAlbumData(String search) async {
    String tokens = tokenId;
    String myUrl1 = "$serverUrl2/auths/verifytoken";
    String msg1 = jsonEncode({"token": "$tokens"});

    final response1 = await http.post(myUrl1,
        headers: {
          'Accept': 'application/json',
          "content-type": "application/json"
        },
        body: msg1);
    status = response1.body.contains('error');

    var data1 = json.decode(response1.body);
    accessToken = data1['data']['accessToken'];

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrl2/albums/getall";
    http.Response response = await http.get(myUrl, headers: {
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $value',
      "content-type": "application/json",
      'x-access-token': '$accessToken'
    });

    return List<Map<String, dynamic>>.from(json.decode(response.body)['data']);
  }

  Future<UserProfile> fetchUser() async {
    String tokens = tokenId;
    String myUrl1 = "$serverUrl2/auths/verifytoken";
    String msg1 = jsonEncode({"token": "$tokens"});

    final response1 = await http.post(myUrl1,
        headers: {
          'Accept': 'application/json',
          "content-type": "application/json"
        },
        body: msg1);
    status = response1.body.contains('error');

    var data1 = json.decode(response1.body);
    accessToken = data1['data']['accessToken'];

    String myUrl = "$serverUrl2/users/detail";

    http.Response response = await http.get(myUrl, headers: {
      'Accept': 'application/json',
      // 'Authorization': 'Bearer $value',
      "content-type": "application/json",
      'x-access-token': '$accessToken'
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return UserProfile.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<MediaProfile> fetchMedia(String id) async {
    String myUrl = "$serverUrl2/medium/detail?id=" + id;

    http.Response response = await http.get(myUrl, headers: {
      'Accept': 'application/json',
      "content-type": "application/json"
    });
    print("Url = " + myUrl);
    print("Respone = " + response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MediaProfile.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load media');
    }
  }

  // Future<List> getAlbumData() async {
  //   String tokens = tokenId;
  //   String myUrl1 = "$serverUrl2/auths/verifytoken";
  //   String msg1 = jsonEncode({"token": "$tokens"});
  //
  //   final response1 = await http.post(myUrl1,
  //       headers: {'Accept': 'application/json', "content-type":"application/json"},
  //       body: msg1);
  //   status = response1.body.contains('error');
  //
  //   var data1 = json.decode(response1.body);
  //   accessToken = data1['data']['accessToken'];
  //
  //
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'token';
  //   final value = prefs.get(key) ?? 0;
  //
  //   String myUrl = "$serverUrl2/albums/getall";
  //   http.Response response = await http.get(myUrl, headers: {
  //     'Accept': 'application/json',
  //     // 'Authorization': 'Bearer $value',
  //     "content-type":"application/json",
  //     'x-access-token': '$accessToken'
  //   });
  //   print('Response body : ${response.body}');
  //   return json.decode(response.body);
  // }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
