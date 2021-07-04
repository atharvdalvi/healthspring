import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthspring/screens/doctor_appointment_screen.dart';
import 'package:healthspring/screens/doctor_profile_screen.dart';
import 'package:healthspring/screens/home_screen.dart';
import 'package:healthspring/screens/login_screen.dart';
import 'package:healthspring/widget/doctor_navigation_drawer.dart';
import '../screens/sign_up_screen.dart';

class DoctorHomeScreen extends StatelessWidget {
  var title = [
    'Your Profile',
    'Appointments',
    'Covid-19 Tracker',
    'Logout',
  ];

  var images = [
    'assets/images/doctor.png',
    'assets/images/appointment.png',
    'assets/images/coronavirus.png',
    'assets/images/logout.png',
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void choosemethod(String title) {
      if (title == 'Your Profile') {
        final User user = FirebaseAuth.instance.currentUser;
        final uid = user.uid;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DoctorAccount(uid),
          ),
        );
      }
      if (title == 'Covid-19 Tracker') {
        final User user = FirebaseAuth.instance.currentUser;
        final uid = user.uid;
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
      if (title == 'Appointments') {
        final User user = FirebaseAuth.instance.currentUser;
        final uid = user.uid;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DoctorAppointment(uid),
        ));
      }
      if (title == 'Logout') {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
      }
    }

    return Scaffold(
        key: _scaffoldKey,
        drawer: DoctorNavigationDrawer(),
        backgroundColor: Color(0xEEEEEE),
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
            'Home',
            style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
            textAlign: TextAlign.center,
          ),
        ),
        body: GridView.builder(
            itemCount: title.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 4,
            ),
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  choosemethod(title[index]);
                },
                child: Card(
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        images[index],
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
                        title[index],
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
              );
            }));
  }
}
