import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formkey = GlobalKey<FormState>();
  String email = '';

  void sendemail() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) => Navigator.of(context).pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "We will mail you a link ... Please click on that link to reset your password",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                    key: formkey,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email-Id',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter email-id';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter valid email-id';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value;
                      },
                    )),
                InkWell(
                  onTap: () {
                    sendemail();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFAFAFA), Color(0xFFBDBDBD)],
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFFBDBDBD).withOpacity(0.3),
                              offset: Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Center(
                          child: Text(
                            'Get Reset Link',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
