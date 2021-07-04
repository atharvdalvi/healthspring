import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class TopFive extends StatefulWidget {
  final news;
  TopFive(this.news);
  @override
  _TopFiveState createState() => _TopFiveState();
}

class _TopFiveState extends State<TopFive> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.news.length < 1 ? widget.news.length : 5,
      itemBuilder: (ctx, index) {
        return Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.news[index].urlToImage,
                  height: 200,
                  width: 300,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              right: 5,
              left: 5,
              bottom: 6,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.news[index].title,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      DateFormat('yMMMd')
                          .format(widget.news[index].publishedAt),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
