import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blog/widgets/widget.dart';

class DetailedBlogPage extends StatelessWidget {
  late String imgUrl, title, desc, authorName;
  DetailedBlogPage(
      {required this.imgUrl,
      required this.title,
      required this.desc,
      required this.authorName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(color: Colors.lightGreen),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                  height: 390,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Text(desc),
          ],
        ),
      ),
    );
  }
}
