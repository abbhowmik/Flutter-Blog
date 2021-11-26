import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CrudMethods {
  Future<void> addData(blogData) async {
    await FirebaseFirestore.instance
        .collection("blogs")
        .add(blogData)
        .then((value) => print("Blog Added"))
        .catchError((error) =>
            print("Failed to add Blog for this error  ------>  $error"));
  }

  getBlogData() async {
    await Firebase.initializeApp()
        .whenComplete(() => print("Completed initialization ☺☺☺☺☺☺☺"));
    return await FirebaseFirestore.instance.collection("blogs").get();
  }
}
