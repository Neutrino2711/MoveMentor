import 'dart:async';
import 'package:status_code0/models/api_integrate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:status_code0/screens/activity.dart';
import 'package:status_code0/widgets/custom_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:status_code0/screens/nav_controller_page.dart';
import 'package:pedometer/pedometer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:status_code0/models/user_data.dart';
import 'package:provider/provider.dart';
import 'package:status_code0/models/google_signin.dart';

final _firestore = FirebaseFirestore.instance;

class AddDatapage extends StatefulWidget {
  AddDatapage({
    super.key,
  });

  final StreamController<String> _controller = StreamController<String>();

  @override
  State<AddDatapage> createState() => _AddDatapageState();
}

class _AddDatapageState extends State<AddDatapage> {
  DateTime? _selectedDate;
  final _formatter = DateFormat.yMMMd();
  // ApiIntegrate _apiIntegrate = ApiIntegrate();

  // late Stream<StepCount> _stepCountStream;
  // late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', steps = '?';
  // Future<void> initPlatformState() async {
  //   _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
  //   _pedestrianStatusStream
  //       .listen(onPedestrianStatusChanged)
  //       .onError(onPedestrianStatusError);

  //   _stepCountStream = await Pedometer.stepCountStream;
  //   _stepCountStream.listen(onStepCount).onError(onStepCountError);

  //   // if (!mounted) return;
  // }

  // void onStepCount(StepCount event) {
  //   print(event);

  //   steps = event.steps.toString();
  //   print(steps);
  // }

  // void onPedestrianStatusChanged(PedestrianStatus event) {
  //   print(event);

  //   _status = event.status;
  // }

  // void onPedestrianStatusError(error) {
  //   print('onPedestrianStatusError: $error');

  //   _status = 'Pedestrian Status not available';

  //   print(_status);
  // }

  // void onStepCountError(error) {
  //   print('onStepCountError: $error');

  //   steps = 'Step Count not available';
  // }

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // void getMessages()async
  // {
  //   await for (var in _firestore.collection('features').)
  // }
  TextEditingController _sleep_controller = TextEditingController();
  TextEditingController _height_controller = TextEditingController();
  TextEditingController _weight_controller = TextEditingController();
  TextEditingController _water_controller = TextEditingController();
  TextEditingController _gender_controller = TextEditingController();
  TextEditingController _age_controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _age_controller.dispose();
    _gender_controller.dispose();
    _height_controller.dispose();
    _water_controller.dispose();
    _sleep_controller.dispose();
    _weight_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entriesProvider = Provider.of<UserDataProvider>(context);
    final userProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);

    final user = userProvider.user;
    // Timestamp? dateTimestamp = _selectedDate as Timestamp;
    // print(dateTimestamp);
    // initPlatformState();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Details',
          ),
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "AppName",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Date",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 20.0),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          presentDatePicker();
                        },
                        icon: Icon(Icons.calendar_month),
                        iconSize: 45.0,
                      )
                    ],
                  ),
                ),
                InputTile(
                    leading: "Water",
                    trailing: "Glass",
                    controller: _water_controller),
                InputTile(
                  controller: _sleep_controller,
                  leading: "Sleep",
                  trailing: "hrs",
                ),
                InputTile(
                  controller: _height_controller,
                  leading: "Height",
                  trailing: "cm",
                ),
                InputTile(
                  controller: _weight_controller,
                  leading: "Weight",
                  trailing: "kg",
                ),
                InputTile(
                  controller: _age_controller,
                  leading: "Age",
                  trailing: "Yrs",
                ),
                InputTile(
                    leading: "Gender",
                    trailing: "M/F",
                    controller: _gender_controller),
                TextButton(
                  onPressed: () {
                    entriesProvider.addUserEntries(
                      _gender_controller.text,
                      int.tryParse(_weight_controller.text)!,
                      int.tryParse(_age_controller.text)!,
                      int.tryParse(_water_controller.text)!,
                      int.tryParse(_sleep_controller.text)!,
                      int.tryParse(_height_controller.text)!,
                      _selectedDate!,
                      DateTime.now().month,
                      user.email.toString(),
                      DateFormat.yMMMd().format(_selectedDate!),
                    );

                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => HomePage())));
                  },
                  child: Text(
                    "Submit",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ]),
        ));
  }
}

class InputTile extends StatelessWidget {
  const InputTile({
    super.key,
    required this.leading,
    required this.trailing,
    required TextEditingController controller,
  }) : _sleep_controller = controller;

  final TextEditingController _sleep_controller;
  final String leading, trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            leading,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 20.0),
          ),
          const Spacer(),
          Expanded(
            child: TextField(
              style: const TextStyle(
                color: Colors.black,
              ),
              controller: _sleep_controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(30.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(trailing),
          ),
        ],
      ),
    );
  }
}
