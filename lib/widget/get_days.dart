import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthspring/colorScheme.dart';
import 'package:healthspring/screens/patient_home_screen.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class GetDays extends StatefulWidget {
  final String userid;
  final String specialization;
  final String patientname;

  GetDays(
    this.userid,
    this.specialization,
    this.patientname,
  );

  @override
  _GetDaysState createState() => _GetDaysState();
}

class _GetDaysState extends State<GetDays> {
  bool onDateSelected = false;
  var now = new DateTime.now();
  var day;
  List daylist = [];

  @override
  Widget build(BuildContext context) {
    bool isBooked = false;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('user')
          .where('userId', isEqualTo: widget.userid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: ScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              for (int i = 0;
                  i < snapshot.data.docs[index]['daysavailable'].length;
                  i++) {
                day = int.parse(
                    snapshot.data.docs[index]['daysavailable'][i]['id']);
                while (now.weekday != day) {
                  now = now.add(new Duration(days: 1));
                }

                daylist.add(now);
              }

              print(daylist[0].toIso8601String());

              return Column(
                children: [
                  for (int i = 0; i < daylist.length; i++)
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: dateBgColor,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                FittedBox(
                                  child: Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: dateBgColor,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat.d().format(
                                            daylist[i],
                                          ),
                                          style: TextStyle(
                                            color: dateColor,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          DateFormat.MMM().format(
                                            daylist[i],
                                          ),
                                          style: TextStyle(
                                            color: dateColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Consultation',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      DateFormat.EEEE().format(
                                        daylist[i],
                                      ),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Wrap(
                          children: [
                            for (int j = 0;
                                j <
                                    snapshot.data.docs[index]['timeavailable']
                                        .length;
                                j++)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      color: dateBgColor,
                                      child: Text(snapshot.data.docs[index]
                                          ['timeavailable'][j]['id']),
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Appointment')
                                        .snapshots(),
                                    builder: (context, sn) => Padding(
                                        padding: EdgeInsets.all(5),
                                        child: RaisedButton(
                                            child: Text("Book Slot"),
                                            onPressed: () {
                                              for (int k = 0;
                                                  k < sn.data.docs.length;
                                                  k++) {
                                                if (snapshot.data.docs[index]
                                                                ['timeavailable']
                                                            [j]['id'] ==
                                                        sn.data.docs[k]
                                                            ['time'] &&
                                                    DateFormat.yMMMMd()
                                                            .format(DateTime.parse(sn
                                                                    .data
                                                                    .docs[k]
                                                                ['timestamp']))
                                                            .toString() ==
                                                        DateFormat.yMMMd()
                                                            .format(daylist[i])
                                                            .toString() &&
                                                    widget.userid ==
                                                        sn.data.docs[k]
                                                            ['doctorid']) {
                                                  setState(() {
                                                    isBooked = true;
                                                  });
                                                  break;
                                                }
                                              }
                                              if (isBooked) {
                                                Toast.show(
                                                  'Sorry ! Selected Slot not available',
                                                  context,
                                                );
                                              } else {
                                                final User user = FirebaseAuth
                                                    .instance.currentUser;
                                                final uid = user.uid;
                                                final firestoreid =
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'Appointment')
                                                        .doc();
                                                print(firestoreid.id);
                                                firestoreid.set(
                                                  {
                                                    "time": snapshot.data.docs[
                                                                index]
                                                            ['timeavailable'][j]
                                                        ['id'],
                                                    "day": DateFormat.yMMMMd()
                                                        .format(
                                                      daylist[i],
                                                    ),
                                                    "userid": uid,
                                                    "doctorid": widget.userid,
                                                    "appointmentid":
                                                        firestoreid.id,
                                                    "patientname":
                                                        widget.patientname,
                                                    "specializtion":
                                                        widget.specialization,
                                                    "status": "Scheduled",
                                                    "doctorname": snapshot
                                                            .data.docs[index]
                                                        ['username'],
                                                    "timestamp": daylist[i]
                                                        .toIso8601String(),
                                                    "note": ".",
                                                    "prescription": "."
                                                  },
                                                ).then(
                                                  (value) {
                                                    Toast.show(
                                                        "Appointment Scheduled Successfully",
                                                        context,
                                                        duration:
                                                            Toast.LENGTH_SHORT,
                                                        gravity: Toast.BOTTOM);

                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PatientHomeScreen(),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                            })),
                                  ),
                                ],
                              ),
                            SizedBox()
                          ],
                        )
                      ],
                    ),
                ],
              );
            });
      },
    );
  }
}
