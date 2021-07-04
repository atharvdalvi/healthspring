import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthspring/screens/appointment_booking_screen.dart';
import 'package:healthspring/widget/patient_navigation_drawer.dart';

class PatientHomeScreen extends StatefulWidget {
  @override
  _PatientHomeScreenState createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  void productdetail(context, id, imageinside, patientname) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            AppointmentBookingScreen(id, imageinside, patientname),
      ),
    );
  }

  TextEditingController textEditingController = TextEditingController();
  String searchString;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: PatientNavigationDrawer(),
        appBar: AppBar(
          backgroundColor: Color(0xEEEEEE),
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/menu.svg'),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          elevation: 0,
          title: Text(
            'Book Appointment',
            style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
            textAlign: TextAlign.center,
          ),
        ),
        body: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return Center(
                    child: Text(
                      'No data',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final User user = FirebaseAuth.instance.currentUser;
                  final uid = user.uid;
                  print(uid);
                  return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('user')
                        .doc(uid)
                        .get(),
                    builder: (context, s) => Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 4 / 4,
                        ),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: GestureDetector(
                              onTap: () {
                                print(s.data['name']);
                                print(snapshot.data.docs[index]['id']);
                                productdetail(
                                  context,
                                  snapshot.data.docs[index]['id'],
                                  snapshot.data.docs[index]['imageinside'],
                                  s.data['name'],
                                );
                              },
                              child: Card(
                                elevation: 4,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Image.network(
                                      snapshot.data.docs[index]['image'],
                                      height: 50,
                                      width: 50,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 30,
                                        left: 30,
                                      ),
                                      child: Divider(),
                                    ),
                                    Text(
                                      snapshot.data.docs[index]['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
