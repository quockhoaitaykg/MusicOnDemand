


import 'package:flutter/material.dart';
import 'package:music_app/model/user.dart';
import 'package:music_app/repositories/DatabaseHelper.dart';
import 'file:///D:/SM9/SWD391/music_app/lib/repositories/sign_in_google.dart';
import 'package:music_app/view/update_profile_screen.dart';



class UserProfileScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileHeader(
                avatar: NetworkImage(imageUrl),
                coverImage: NetworkImage(imageUrl),
                title: name,
                subtitle: "Most beautiful user",
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.white,
                    shape: CircleBorder(),
                    elevation: 0,
                    child: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return UpdateProfileScreen();
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              UserInfo(),
            ],
          ),
        ));
  }
}

class UserInfo extends StatelessWidget {
  DatabaseHelper databaseHelper = new DatabaseHelper();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: FutureBuilder<UserProfile>(
                future: databaseHelper.fetchUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                      return Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              ...ListTile.divideTiles(
                                color: Colors.grey,
                                tiles: [
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text("Your name"),
                                    subtitle: Text(snapshot.data.name),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    leading: Icon(Icons.polymer_sharp),
                                    title: Text("Role"),
                                    subtitle: Text(snapshot.data.role),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.email),
                                    title: Text("Email"),
                                    subtitle: Text(email),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.phone),
                                    title: Text("Phone"),
                                    subtitle: Text(snapshot.data.phone),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.cake),
                                    title: Text("Birthdate"),
                                    subtitle: Text(snapshot.data.dob),
                                  ),

                                ],
                              ),
                            ],
                          )
                        ],
                      );
                  }else if (snapshot.hasError){
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  const ProfileHeader(
      {Key key,
        @required this.coverImage,
        @required this.avatar,
        @required this.title,
        this.subtitle,
        this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: coverImage, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 40,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key key,
        @required this.image,
        this.borderColor = Colors.grey,
        this.backgroundColor,
        this.radius = 30,
        this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image,
        ),
      ),
    );
  }
}
