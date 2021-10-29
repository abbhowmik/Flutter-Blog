// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blog/services/crud.dart';
import 'package:flutter_blog/widgets/widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:random_string/random_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  late String authorName, title, description;
  File? image;
  var downloadUrl;

  bool? loading = false;

  Future getImage() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final tempImg = File(image.path);
      setState(() => this.image = tempImg);
    } on PlatformException catch (e) {
      print("error is ----> $e");
    }
  }

  uploadBlogDetatils() async {
    await Firebase.initializeApp();
    if (image != null) {
      setState(() {
        loading = true;
      });
    }

    if (image != null) {
      Reference firebaseStorageRef = await FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");
      UploadTask uploadTask = firebaseStorageRef.putFile(image!);

      uploadTask.whenComplete(() async {
        try {
          downloadUrl = await firebaseStorageRef.getDownloadURL();
        } catch (onError) {
          print("Error is 🤣🤣🤣😂🤣🤣🤣 $onError");
        }

        // then push into database
        Map<String, String> blogMap = {
          "authorName": authorName,
          "title": title,
          "desc": description,
          "imageUrl": downloadUrl,
        };
        CrudMethods()
            .addData(blogMap)
            .then((result) => {Navigator.pop(context)});
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(144, 238, 144, 0.7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        // ignore: prefer_const_constructors
        iconTheme: IconThemeData(color: Colors.white),
        title: appBar2(context),
        actions: [
          GestureDetector(
            onTap: () {
              uploadBlogDetatils();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Icons.file_upload),
            ),
          )
        ],
      ),
      // ignore: avoid_unnecessary_containers
      body: loading == true
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                height: 670,
                child: Column(
                  children: [
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      // ignore: unnecessary_null_comparison
                      child: image != null
                          ? (Container(
                              margin: EdgeInsets.symmetric(horizontal: 7),
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(image!, fit: BoxFit.cover)),
                            ))
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 7),
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              // ignore: prefer_const_constructors
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black54,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 49,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 19),
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Author',
                            ),
                            onChanged: (val) {
                              authorName = val;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Title',
                            ),
                            onChanged: (val) {
                              title = val;
                            },
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Description',
                            ),
                            onChanged: (val) {
                              description = val;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
