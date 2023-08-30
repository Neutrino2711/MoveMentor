import 'package:intl/intl.dart';

class User {
  String gender, id;
  int weight, age, water, sleep, height, month;
  DateTime date;

  User({
    required this.id,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.sleep,
    required this.water,
    required this.date,
    required this.month,
  });
}
