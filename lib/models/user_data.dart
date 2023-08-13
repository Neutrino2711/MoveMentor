import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  void addData(String water, sleep, steps, int weight) {
    // _firestore.collection('features').add();
  }
}
