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
  final _formatter = DateFormat.yMd();
  // ApiIntegrate _apiIntegrate = ApiIntegrate();

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', steps = '?';
  Future<void> initPlatformState() async {
    _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = await Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    // if (!mounted) return;
  }

  void onStepCount(StepCount event) {
    print(event);

    steps = event.steps.toString();
    print(steps);
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);

    _status = event.status;
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');

    _status = 'Pedestrian Status not available';

    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');

    steps = 'Step Count not available';
  }

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

  @override
  Widget build(BuildContext context) {
    initPlatformState();
    TextEditingController _sleep_controller = TextEditingController();
    TextEditingController _height_controller = TextEditingController();
    TextEditingController _weight_controller = TextEditingController();
    TextEditingController _water_controller = TextEditingController();
    TextEditingController _gender_controller = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text(
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
                CustomInputField(
                  water_controller: _water_controller,
                  label: "Water",
                  isWater: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Sleep",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 20.0),
                      ),
                      Spacer(),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
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
                        child: Text("hrs"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Height",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 20.0),
                      ),
                      Spacer(),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          controller: _height_controller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("cm"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Weight",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 20.0),
                      ),
                      Spacer(),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          controller: _weight_controller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("kg"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            "Gender",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 20.0),
                          ),
                          Spacer(),
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: _gender_controller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('''M/F'''),
                          ),
                        ],
                      ),
                    ),
                    // Text(steps),
                    // StreamBuilder<String>(
                    //   stream: _controller.stream,
                    //   builder: ())
                  ]),
                ),
                TextButton(
                  onPressed: () {
                    _firestore.collection('features').add({
                      'Height': _height_controller.text,
                      'Sleep': _sleep_controller.text,
                      'Steps': steps,
                      'Water': _water_controller.text,
                      'Weight': int.parse(_weight_controller.text),
                      'Date': _formatter.format(_selectedDate!)
                    });
                    print(steps);
                    print(_water_controller.text);
                    print(_sleep_controller.text);
                    print(_weight_controller.text);
                    print(_height_controller.text);
                    print(_formatter.format(_selectedDate!));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => HomePage(
                                steps_: steps,
                                sleep_: _sleep_controller.text,
                                water_: _water_controller.text,
                                weight_: int.parse(_weight_controller.text)))));
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
