import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserController with ChangeNotifier {
  bool admin = false;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> loadCurrentUser(String id) async {
    if (id != null) {
      try {
        //verificando usuario admin
        final docAdmin = await firestore.collection('admins').doc(id).get();

        if (docAdmin.exists) {
          admin = true;
        }

        notifyListeners();
      } catch (e) {}
      notifyListeners();
    }
  }
}
