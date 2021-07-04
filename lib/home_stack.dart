import 'package:flutter/material.dart';

class HomeStack extends StatelessWidget {
  final mostAffected;
  HomeStack(this.mostAffected);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Most Affected Country',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.start,
          ),
        ),
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (ctx, index) => Container(
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
            child: Row(
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
                      'Active:  ' + mostAffected[index]['active'].toString(),
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
                      'Death:  ' + mostAffected[index]['deaths'].toString(),
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
      ],
    );
  }
}
