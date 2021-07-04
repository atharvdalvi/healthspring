import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthspring/screens/about_us_screen.dart';
import 'package:healthspring/screens/contact_us.dart';
import 'package:healthspring/screens/doctor_appointment_screen.dart';
import 'package:healthspring/screens/doctor_dashboard.dart';
import 'package:healthspring/screens/doctor_home_screen.dart';
import 'package:healthspring/screens/doctor_profile_screen.dart';
import 'package:healthspring/screens/login_screen.dart';

class DoctorNavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser;
    final userId = userid.uid;
    return Drawer(
      child: FutureBuilder(
        future: FirebaseFirestore.instance.collection('user').doc(userId).get(),
        builder: (c, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Container(
                color: Colors.blue,
                padding: EdgeInsets.only(
                  top: 50,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data['profile_image']),
                      ),
                    ),
                    Text(
                      snapshot.data['username'],
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      snapshot.data['email'],
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  'Home',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DoctorHomeScreen(),
                  ));
                },
              ),
              ListTile(
                title: Text(
                  'Your Account',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  final User user = FirebaseAuth.instance.currentUser;
                  final uid = user.uid;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DoctorAccount(uid),
                  ));
                },
              ),
              ListTile(
                title: Text(
                  'Your Appointments',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  final User user = FirebaseAuth.instance.currentUser;
                  final uid = user.uid;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DoctorAppointment(uid),
                  ));
                },
              ),
              ListTile(
                title: Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  final User user = FirebaseAuth.instance.currentUser;
                  final uid = user.uid;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DoctorDashboard(uid),
                  ));
                },
              ),
              ListTile(
                title: Text(
                  'Contact us',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Contactus(),
                  ));
                },
              ),
              ListTile(
                title: Text(
                  'About us',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AboutusScreen(),
                  ));
                },
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
