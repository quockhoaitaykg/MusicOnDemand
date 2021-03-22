
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'file:///D:/SM9/SWD391/music_app/lib/repositories/DatabaseHelper.dart';
import 'file:///D:/SM9/SWD391/music_app/lib/repositories/sign_in_google.dart';

import 'package:music_app/view/home_screen.dart';
import 'package:music_app/view/user_profile_screen.dart';

class AuthenScreen extends StatefulWidget {
  static const String id = 'authen_screen';

  @override
  _AuthenScreenState createState() => _AuthenScreenState();
}

class _AuthenScreenState extends State<AuthenScreen> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  bool formVisible;
  int _formsIndex;

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/authen_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.black54,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: kToolbarHeight + 40),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Welcome",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 30.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            "Welcome to Music coffee. \n You are awesome",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text("Login"),
                            onPressed: () {
                              setState(() {
                                formVisible = true;
                                _formsIndex = 1;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: RaisedButton(
                            color: Colors.grey.shade700,
                            textColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text("Signup"),
                            onPressed: () {
                              setState(() {
                                formVisible = true;
                                _formsIndex = 2;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    OutlineButton.icon(
                      borderSide: BorderSide(color: Colors.red),
                      color: Colors.red,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      icon: Icon(FontAwesomeIcons.google),
                      label: Text("Login with Google"),
                      onPressed: () {

                        signInWithGoogle().then((result) {
                          if (result != null) {

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomeScreen();
                                },
                              ),
                            );
                            databaseHelper.vertifyToken();
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    // OutlineButton.icon(
                    //   borderSide: BorderSide(color: Colors.lightBlue),
                    //   color: Colors.lightBlue,
                    //   textColor: Colors.white,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20.0),
                    //   ),
                    //   icon: Icon(FontAwesomeIcons.facebook),
                    //   label: Text("Login with Facebook"),
                    //   onPressed: () {
                    //     signInWithGoogle().then((result) {
                    //       if (result != null) {
                    //         Navigator.of(context).push(
                    //           MaterialPageRoute(
                    //             builder: (context) {
                    //               return HomeScreen();
                    //             },
                    //           ),
                    //         );
                    //       }
                    //     });
                    //   },
                    // ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: (!formVisible)
                    ? null
                    : Container(
                  color: Colors.black54,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            textColor: _formsIndex == 1
                                ? Colors.white
                                : Colors.black,
                            color:
                            _formsIndex == 1 ? Colors.red : Colors.white,
                            child: Text("Login"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            onPressed: () {

                              setState(() {
                                _formsIndex = 1;
                              });
                            },
                          ),
                          const SizedBox(width: 10.0),
                          RaisedButton(
                            textColor: _formsIndex == 2
                                ? Colors.white
                                : Colors.black,
                            color:
                            _formsIndex == 2 ? Colors.red : Colors.white,
                            child: Text("Signup"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            onPressed: () {
                              setState(() {
                                _formsIndex = 2;
                              });
                            },
                          ),
                          const SizedBox(width: 10.0),
                          IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                formVisible = false;
                              });
                            },
                          )
                        ],
                      ),
                      Container(
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child:
                          _formsIndex == 1 ? LoginForm() : SignupForm(),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: "Enter email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Login"),
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
          ),
        ],
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: "Enter email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Confirm password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Signup"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}