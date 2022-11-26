import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  final String? uid;
  final String name;
  final String email;

  UsersModel({required this.name, required this.email, required this.uid});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'email': email,
    };
  }

  UsersModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : name = doc.data()!["name"],
        email = doc.data()!["email"],
        uid = doc.data()!["uid"];
}
