import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthspring/widget/patient_navigation_drawer.dart';

class Contactus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
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
            'Contact Us',
            style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
            textAlign: TextAlign.center,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'How can we Help?',
                style: TextStyle(fontSize: 30),
              ),
              Text('Want to get in touch with us?We would like to hear you'),
              Row(
                children: [
                  Text('Our email-id : '),
                  Text(
                    'admin@admin.com',
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
              Text('Drop a mail and we will reply you within next 24-48 hrs')
            ],
          ),
        ),
      ),
    );
  }
}
