
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogPostDetails extends StatefulWidget {
  final postindex;
  BlogPostDetails(this.postindex);
  @override
  _BlogPostDetailsState createState() => _BlogPostDetailsState();
}

class _BlogPostDetailsState extends State<BlogPostDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.postindex.data["posttitle"]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.network(widget.postindex.data["imglink"]),
            ),
            SizedBox(height: 10.0),
            Text("স্থানের নামঃ ${widget.postindex.data["posttitle"]}",style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w400
            ),
            ),
            SizedBox(height: 17.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                       "পোস্টের সময়ঃ ${DateFormat.yMMMMd().format(DateTime.now())}", style: TextStyle(
                      fontSize: 16.0,

                  ),
                  ),
                  GestureDetector(child: Icon(Icons.favorite_border),
                    onTap: (){
                    setState(() {
                    });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 17.0),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(widget.postindex.data["postdesc"],
                softWrap: true,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w300
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
