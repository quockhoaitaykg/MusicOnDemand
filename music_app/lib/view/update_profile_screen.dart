import 'file:///D:/SM9/SWD391/music_app/lib/repositories/DatabaseHelper.dart';

import 'package:music_app/model/user.dart';
import 'package:music_app/view/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/view/user_profile_screen.dart';
import 'package:music_app/widget/constants.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String id = 'update_profile_screen';
  List list;
  int index;

  UpdateProfileScreen({this.index, this.list});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _imageController = new TextEditingController();
  final TextEditingController _priceController =
  new TextEditingController();
  final TextEditingController _birthController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();

  DatabaseHelper databaseHelper = new DatabaseHelper();

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              // hintText: '${widget.list[widget.index]['bookName']}',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }




  Widget _buildDobTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Date of birth',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: _birthController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.perm_contact_calendar_outlined,
                color: Colors.white,
              ),
              // hintText: '${widget.list[widget.index]['price']}',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildImageTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Image url',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: _imageController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.image,
                color: Colors.white,
              ),
              // hintText: '${widget.list[widget.index]['pagesNumber']}',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  final RegExp emailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");



  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{8}$');

  Widget _buildPhoneTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(

            controller: _phoneController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.apps_sharp,
                color: Colors.white,
              ),
              // hintText: '${widget.list[widget.index]['quantity']}',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Update Fail'),
            content: new Text('Ấn đóng để sửa :))'),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(
                  'Close',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showSuccessDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Update Success'),
            content: new Text('Press OK to continue'),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(
                  'OK',
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return UserProfileScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          );
        });
  }

  void showProcessingDialog() async{
    return showDialog(

        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){

          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
              content: Container(
                  width: 250.0,
                  height: 100.0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircularProgressIndicator(),
                        Text("     Updating...",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                color:  Color(0xFF5B6978)
                            )
                        )
                      ]
                  )
              )


          );
        }
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () async {
        Navigator.pop(context);
        databaseHelper.updateUserData(
            _nameController.text.trim(),
            _phoneController.text.trim(),
            _birthController.text.trim(),
            _imageController.text.trim()
        );

        showProcessingDialog();
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
        _showSuccessDialog();

      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to update this information ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildUpdateBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 150,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
            showAlertDialog(context);


        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'UPDATE',
          style: TextStyle(
            color: Colors.blue,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  Widget _buildCancelBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 150,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.pop(context, HomeScreen.id);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.redAccent,
        child: Text(
          'CANCEL',
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
          _buildCancelBtn(),
          SizedBox(width: 20),
          _buildUpdateBtn(),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff100a20),
      body: Form(
        autovalidate: false,
        key: _formKey,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,

              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 80.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      _buildNameTF(),
                      // SizedBox(height: 10.0),
                      // _buildPositionTF(),
                      // SizedBox(height: 10.0),
                      // _buildLocationTF(),
                      SizedBox(height: 10.0),
                      _buildImageTF(),
                      SizedBox(height: 10.0),
                      _buildPhoneTF(),
                      SizedBox(height: 10.0),
                      _buildDobTF(),
                      SizedBox(height: 10.0),
                      _buildBtnRow(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



