import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

mixin FirebaseUserMange {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addUser(UsersModel userData) async {
    await _db.collection("users").add(userData.toMap());
  }

  updateUser(UsersModel userData) async {
    await _db.collection("users").doc(userData.uid).update(userData.toMap());
  }

  Future<void> deleteUser(String documentId) async {
    await _db.collection("users").doc(documentId).delete();
  }

  Future<List<UsersModel>> retrieveUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("users").get();
    return snapshot.docs
        .map((docSnapshot) => UsersModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
