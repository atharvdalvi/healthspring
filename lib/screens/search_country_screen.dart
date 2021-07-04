import 'package:flutter/material.dart';
import 'package:healthspring/search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchCountryScreen extends StatefulWidget {
  @override
  _SearchCountryScreenState createState() => _SearchCountryScreenState();
}

class _SearchCountryScreenState extends State<SearchCountryScreen> {
  List mostAffected;
  void fectchCountryData() async {
    final urll = 'https://corona.lmao.ninja/v2/countries';
    final url = Uri.parse(urll);

    final response = await http.get(url);

    setState(() {
      mostAffected = json.decode(response.body);
    });
    print(mostAffected);
  }

  @override
  void initState() {
    // TODO: implement initState
    fectchCountryData();
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.green,
              ),
              onPressed: () {
                mostAffected == null
                    ? null
                    : showSearch(
                        context: context, delegate: Search(mostAffected));
              })
        ],
      ),
      body: ListView.builder(
        itemCount: mostAffected == null ? 0 : mostAffected.length,
        itemBuilder: (ctx, index) => mostAffected == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsets.all(8),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF60BE93),
                        Color(0xFF1B8D59),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Image.network(
                          mostAffected[index]['countryInfo']['flag'],
                          width: 100,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            mostAffected[index]['country'],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            'Total Cases:  ' +
                                mostAffected[index]['cases'].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                          Text(
                            'Active:  ' +
                                mostAffected[index]['active'].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                          Text(
                            'Recovered:  ' +
                                mostAffected[index]['recovered'].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                          Text(
                            'Death:  ' +
                                mostAffected[index]['deaths'].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
