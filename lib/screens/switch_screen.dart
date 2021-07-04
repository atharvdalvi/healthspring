import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthspring/screens/admin_home_screen.dart';
import 'package:healthspring/screens/doctor_home_screen.dart';
import 'package:healthspring/screens/intro_screen.dart';
import 'package:healthspring/screens/login_screen.dart';
import 'package:healthspring/screens/patient_home_screen.dart';

class SwitchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, homeSnapshot) {
              if (homeSnapshot.data != null) {
                if (homeSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final userid = FirebaseAuth.instance.currentUser;
                  final userId = userid.uid;

                  return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('user')
                          .doc(userId)
                          .get(),
                      builder: (c, snapshots) {
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshots.data['profile'] == 'Patient') {
                            return PatientHomeScreen();
                          } else if (snapshots.data['profile'] == 'Admin') {
                            return AdminHomeScreen();
                          } else if (snapshots.data['profile'] == 'Doctor') {
                            return DoctorHomeScreen();
                          }
                          return null;
                        }
                      });
                }
              } else {
                return IntroScreen();
              }
            }));
  }
}
