import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthspring/widget/patient_navigation_drawer.dart';

class AboutusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
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
          'About Us',
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.blue,
        padding: const EdgeInsets.all(15.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quality Helthcare Made Simple',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Our Mission',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Med4u is on a mission to make quality healthcare affordable and accessible for over a billion+ Indians. We believe in empowering our users with the most accurate, comprehensive, and curated information and care, enabling them to make better healthcare decisions.',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Our offerings',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('• Online consultation with trusted doctors '),
                  Text('• Each time a patient finds the right doctor '),
                  Text(
                      '• Data privacy and security has always served as one of the founding philosophies of Med4u, and we go to great lengths to safeguard the confidentiality and integrity of our users.  '),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
