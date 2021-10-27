import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {
  Future<void> addData(blogData) async {
    FirebaseFirestore.instance
        .collection("blogs")
        .add(blogData)
        .then((value) => print("Blog Added"))
        .catchError((error) =>
            print("Failed to add Blog for this error  ------>  $error"));
  }
}
