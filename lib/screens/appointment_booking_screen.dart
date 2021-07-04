import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:healthspring/colorScheme.dart';
import 'package:healthspring/widget/get_days.dart';

class AppointmentBookingScreen extends StatefulWidget {
  final String id;
  final String imageinside;
  final String patientname;

  AppointmentBookingScreen(this.id, this.imageinside, this.patientname);

  @override
  _AppointmentBookingScreenState createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  String userid = '';
  String specialization = '';
  bool getappointmentselected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [getStartedColorStart, getStartedColorEnd],
              begin: Alignment(0, -1.15),
              end: Alignment(0, 0.1),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Image.network(widget.imageinside),
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .where('specialization', isEqualTo: widget.id)
                      .snapshots(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  primary: false,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 100,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                snapshot.data.docs[index]
                                                    ['profile_image'],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data.docs[index]
                                                      ['username'],
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data.docs[index]
                                                      ['specialization'],
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "About Doctor",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      Text(snapshot.data.docs[index]
                                          ['description']),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          userid = snapshot.data.docs[index]
                                              ['userId'];
                                          specialization = snapshot.data
                                              .docs[index]['specialization'];

                                          setState(() {
                                            getappointmentselected = true;
                                          });
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF17ead9),
                                                  Color(0xFF6078ea)
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
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
                                                  'Check Time Slot',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 18,
                                                      letterSpacing: 1.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                getappointmentselected
                                    ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Available Time Slot",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 10,
                                      ),
                                getappointmentselected
                                    ? GetDays(userid, specialization,
                                        widget.patientname)
                                    : SizedBox(
                                        height: 10,
                                      )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
