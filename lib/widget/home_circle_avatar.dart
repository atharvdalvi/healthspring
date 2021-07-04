import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Instructions',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  const url =
                      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/when-and-how-to-use-masks';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundColor: Colors.green.withOpacity(0.1),
                      child: ClipOval(
                        child: Image.asset('assets/images/mask.png'),
                      ),
                    ),
                    Text(
                      'When to  \n  use masks',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  const url =
                      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundColor: Colors.green.withOpacity(0.1),
                      backgroundImage: AssetImage('assets/images/myth.jpg'),
                    ),
                    Text(
                      'Myth \n Buster',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  const url =
                      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/donate';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundColor: Colors.green.withOpacity(0.1),
                      backgroundImage: AssetImage('assets/images/donate.jpg'),
                    ),
                    Text(
                      'Donate \n (WHO)',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
