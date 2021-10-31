// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blog/services/crud.dart';
import 'package:flutter_blog/views/createBlog.dart';
import 'package:flutter_blog/widgets/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  QuerySnapshot? blogSnapShot;

  Widget BlogList2() {
    return Container(
      child: FutureBuilder(
        future: CrudMethods().getBlogData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: blogSnapShot!.docs.length,
                itemBuilder: (context, index) {
                  return Blogs2Tile();
                });
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Container(child: Center(child: Text("No data")));
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget BlogList() {
    return Container(
      child: blogSnapShot != null
          ? Column(
              children: [
                ListView.builder(
                    itemCount: blogSnapShot!.docs.length,
                    itemBuilder: (context, index) {
                      return BlogsTile(
                        imgUrl: blogSnapShot!.docChanges[index].doc['imageUrl'],
                        title: blogSnapShot!.docChanges[index].doc['title'],
                        desc: blogSnapShot!.docChanges[index].doc['desc'],
                        authorName:
                            blogSnapShot!.docChanges[index].doc['authorName'],
                      );
                    }),
              ],
            )
          : Container(
              child: Center(
              child: CircularProgressIndicator(),
            )),

      // ignore: avoid_unnecessary_containers
    );
  }

  @override
  void initState() {
    CrudMethods().getBlogData().then((value) {
      setState(() {
        blogSnapShot = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        elevation: 0,
        title: appBar(context),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 24, bottom: 22), child: BlogList2()),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("         "),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateBlog()));
              },
              // ignore: prefer_const_constructors
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Blogs2Tile extends StatelessWidget {
  const Blogs2Tile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 175,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.network(
                "https://th.bing.com/th/id/OIP.OF59vsDmwxPP1tw7b_8clQHaE8?pid=ImgDet&rs=1",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              height: 175,
              decoration: BoxDecoration(
                color: Colors.black87.withOpacity(0.13),
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Sunrise in Puri",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                      "tBrush up your skills or learn from scratch. Increase your pace of learning  scratch. Increase your pace of learnin  scratch. Increase your pace of learnin  scratch. Increase your pace of learnin",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "_ Ashis Bhowmik",
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogsTile extends StatelessWidget {
  late String imgUrl, title, desc, authorName;
  BlogsTile({
    required this.imgUrl,
    required this.title,
    required this.desc,
    required this.authorName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Stack(
        children: [
          // Image.network(imgUrl),
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.0),
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(desc),
                Text(authorName),
              ],
            ),
          )
        ],
      ),
    );
  }
}
