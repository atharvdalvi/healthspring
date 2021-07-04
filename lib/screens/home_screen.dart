import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthspring/home_stack.dart';
import 'package:healthspring/widget/home_circle_avatar.dart';
import 'package:healthspring/widget/home_grid.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map worldData;
  List mostAffected;

  void getall() async {
    final urll = 'https://corona.lmao.ninja/v2/all';
    final url = Uri.parse(urll);
    final response = await http.get(url);
    setState(() {
      worldData = json.decode(response.body);
    });
    print(worldData['cases']);
  }

  void mostInfected() async {
    final urll = 'https://corona.lmao.ninja/v2/countries';
    final url = Uri.parse(urll);

    final response = await http.get(url);

    setState(() {
      mostAffected = json.decode(response.body);
      mostAffected.sort((a, b) => b['cases'].compareTo(a['cases']));
    });
    print(mostAffected);
  }

  @override
  void initState() {
    getall();
    mostInfected();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.1),
        elevation: 0,
        title: Center(
          child: Text(
            'Covid-19 Tracker',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                child: worldData == null
                    ? Center(
                        child: Text('No Text to Show'),
                      )
                    : HomeGrid(worldData),
              ),
              HomeCircle(),
              mostAffected == null ? Container() : HomeStack(mostAffected),
            ],
          ),
        ),
      ),
    );
  }
}
