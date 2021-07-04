import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:healthspring/screens/login_screen.dart';
import 'package:healthspring/screens/splash_screen.dart';
import 'package:healthspring/widget/image_pick.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'signupscreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  String emailid = '';
  String password = '';
  String username = '';
  String age = '';
  String mobileno = '';
  File pickedImage;
  String isStaff;
  bool isLoading = false;

  void _getImage(File image) {
    pickedImage = image;
  }

  void _submitAuthForm(ctx) async {
    try {
      UserCredential authResult;

      if (formKey.currentState.validate()) {
        formKey.currentState.save();

        setState(() {
          isLoading = true;
        });
        var authResult = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailid,
          password: password,
        )
            .catchError((error) {
          var errorMessage = 'Authentication failed';
          if (error.toString().contains('EMAIL_EXISTS')) {
            errorMessage = 'This email address is already in use.';
          } else if (error.toString().contains('INVALID_EMAIL')) {
            errorMessage = 'This is not a valid email address';
          } else if (error.toString().contains('WEAK_PASSWORD')) {
            errorMessage = 'This password is too weak.';
          } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
            errorMessage = 'Could not find a user with that email.';
          } else if (error.toString().contains('INVALID_PASSWORD')) {
            errorMessage = 'Invalid password.';
          }

          Toast.show(
            errorMessage,
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
          );
        });

        FirebaseFirestore.instance
            .collection('user')
            .doc(authResult.user.uid)
            .set({
          'name': username,
          'emailid': emailid,
          'age': age,
          'profile': 'Patient',
          'mobileno': mobileno
        });

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => LoginScreen(),
          ),
        );
      }
    } on PlatformException catch (err) {
      var message = 'An error occured,Please check credentials!';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Image.asset('assets/images/login_background.jpg'),
                    )
                  ],
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 160),
                        Container(
                          width: double.infinity,
                          height: 650,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 15.0),
                                    blurRadius: 15.0),
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, -19.0),
                                    blurRadius: 15.0),
                              ]),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontFamily: "Poppins",
                                        letterSpacing: .6,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "E-mail",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 20),
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'E-mail',
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 12)),
                                    onSaved: (value) {
                                      emailid = value;
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please enter email';
                                      }
                                      if (!value.contains('@')) {
                                        return 'Please enter vaild email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 20),
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Name',
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 12)),
                                    onSaved: (value) {
                                      username = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Mobile No",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 20),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: 'Mobile No',
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 12)),
                                    onSaved: (value) {
                                      mobileno = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Mobile no';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Age",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 20),
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Age',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    onSaved: (value) {
                                      age = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Age';
                                      }
                                      return null;
                                    },
                                  ),
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 20),
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 12)),
                                    obscureText: true,
                                    onSaved: (value) {
                                      password = value;
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please enter password';
                                      }
                                      if (value.length <= 5) {
                                        return 'Please enter bigger password';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                _submitAuthForm(context);
                              },
                              child: Container(
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF17ead9),
                                        Color(0xFF6078ea)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(6.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xFF6078ea)
                                              .withOpacity(0.3),
                                          offset: Offset(0.0, 8.0),
                                          blurRadius: 8.0)
                                    ]),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    child: Center(
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
