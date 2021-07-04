import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthspring/screens/doctor_home_screen.dart';
import 'package:toast/toast.dart';

class ChangeStatus extends StatelessWidget {
  final String appointmentid;
  ChangeStatus(this.appointmentid);

  TextEditingController note = TextEditingController();
  TextEditingController prescription = TextEditingController();

  void changeStatus(appointmentid, context) {
    if (!note.text.isEmpty) {
      if (!prescription.text.isEmpty) {
        FirebaseFirestore.instance
            .collection('Appointment')
            .doc(appointmentid)
            .update({
          "status": "Completed",
          "note": note.text,
          "prescription": prescription.text,
        }).then((value) {
          Navigator.of(context).pop(MaterialPageRoute(
            builder: (context) => DoctorHomeScreen(),
          ));
        });
      } else {
        Toast.show("Please add prescription", context, duration: 10);
      }
    } else {
      Toast.show("Please add note", context, duration: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Appointment')
              .doc(appointmentid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data['day'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        Text(
                          snapshot.data['time'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Text(
                                  snapshot.data['status'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Doctor Name : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              snapshot.data['doctorname'],
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Doctor Specialization : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              snapshot.data['specializtion'],
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Patient Name : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              snapshot.data['patientname'],
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Appointment Id : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              snapshot.data['appointmentid'],
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        Text(
                          'Note',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Note'),
                          controller: note,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Prescription',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Prescription'),
                          controller: prescription,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            changeStatus(
                              snapshot.data['appointmentid'],
                              context,
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF17ead9),
                                    Color(0xFF6078ea)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(0.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: Center(
                                  child: Text(
                                    'Change Status',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
