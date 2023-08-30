import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:status_code0/models/user.dart';

class UserDataProvider extends ChangeNotifier {
//  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<User> user = [];

  List<User> get Userentries => user;

  final _firestore = FirebaseFirestore.instance;
  Future<void> addUserEntries(
    String gender,
    int weight,
    int age,
    int water,
    int sleep,
    int height,
    DateTime date,
    int month,
    String id,
  ) async {
    // _firestore.collection('features').add();
    final newEntry = User(
      id: id,
      age: age,
      sleep: sleep,
      weight: weight,
      height: height,
      gender: gender,
      water: water,
      date: date,
      month: month,
    );

    await _firestore.collection('features').add({
      'Id': newEntry.id,
      'Height': newEntry.height,
      'Sleep': newEntry.sleep,
      'Water': newEntry.water,
      'Weight': newEntry.weight,
      'Date': newEntry.date,
      'Age': newEntry.age,
      'Gender': newEntry.gender,
      'Month': newEntry.month
    });

    user.add(newEntry);
    notifyListeners();
  }

  Future<void> fetchEntries(String dateTime, String email) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('features')
          .where(
            'Date',
            isEqualTo: dateTime,
          )
          .where(
            'Id',
            isEqualTo: email,
          )
          .get();
      // print(snapshot.size);
      user = snapshot.docs
          .map(
            (doc) => User(
              id: doc['Id'],
              age: doc['Age'],
              sleep: doc['Sleep'],
              water: doc['Water'],
              height: doc['Height'],
              weight: doc['Weight'],
              gender: doc['Gender'],
              date: doc['Date'],
              month: doc['Month'],
            ),
          )
          .toList();
      print("inside fetch");
      // print(user.length);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // void fetchData(DateTime date) async {
  //   User user = User();

  //   final _firestore = await _firebaseFirestore
  //       .collection('features')
  //       .where('Date', isEqualTo: date)
  //       .get();

  //   for (var snapshot in _firestore.docs) {
  //     print(snapshot.data());
  //   }

  //   return user;
  // }
}


//  final userdata = snapshot.data!.docs.reversed;
//           List<int> weights = [], ages = [];
//           List<String> genders = [],
//               sleeps = [],
//               steps = [],
//               waters = [],
//               heights = [];

//           for (var data in userdata) {
//             final curr_data = data.data();
//             weights.add((curr_data['Weight']));
//             ages.add((curr_data['Ages']));
//             sleeps.add((curr_data['Sleep']));
//             steps.add(curr_data['Steps']);
//             waters.add(curr_data['Water']);
//             heights.add(curr_data['Height']);
//             genders.add(curr_data['Gender']);
//           }
//           user.age = ages[0];
//           user.gender = genders[0];
//           user.height = heights[0];
//           user.sleep = sleeps[0];
//           user.steps = steps[0];
//           user.water = waters[0];
//           user.weight = weights[0];
//         }
//       },