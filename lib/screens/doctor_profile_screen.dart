import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorAccount extends StatefulWidget {
  final userid;

  DoctorAccount(this.userid);

  @override
  _UpdateUserDetailScreenState createState() => _UpdateUserDetailScreenState();
}

class _UpdateUserDetailScreenState extends State<DoctorAccount> {
  var mobileno;
  var address;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('user')
                    .doc(widget.userid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Your Account',
                                        style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Name",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFormField(
                                        initialValue: snapshot.data['username'],
                                        enabled: false,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Specialization",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFormField(
                                        initialValue:
                                            snapshot.data['specialization'],
                                        enabled: false,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "E-mail id",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFormField(
                                        initialValue: snapshot.data['email'],
                                        enabled: false,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Contact no",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFormField(
                                        initialValue: snapshot.data['mobileno'],
                                        enabled: false,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Description",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFormField(
                                        initialValue:
                                            snapshot.data['description'],
                                        enabled: false,
                                        maxLines: 10,
                                        minLines: 1,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}
