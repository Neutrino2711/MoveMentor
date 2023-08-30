import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:status_code0/widgets/custom_blocks.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:status_code0/models/api_integrate.dart';
import 'package:status_code0/models/data_stream.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:status_code0/models/user_data.dart';
import 'package:status_code0/models/google_signin.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen(
      {super.key,
      required this.steps,
      required this.sleep,
      required this.water,
      required this.weight});

  final String steps;
  final int weight;
  final String sleep;
  final String water;

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DateTime _selectedDate = DateTime.now();
  String? date_;
  Future<void> presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate!;
      date_ = DateFormat.yMMMd().format(_selectedDate).toString();
      print("check again");
    });
    // await getData(date_!);
  }

  @override
  void initState() {
    // TODO: implement initState
    // ApiIntegrate _apiIntegrate =
    //     ApiIntegrate(Sleep: widget.sleep, Steps: widget.steps);
    // _apiIntegrate.api_inte();
    super.initState();
  }

  List<Map<String, dynamic>>? data;

  Future<void> getData(String date, String email) async {
    final _snapshots = await _firestore
        .collection('features')
        .where('Date', isEqualTo: date)
        .get();
    print(_snapshots.docs);
    for (var snapshot in _snapshots.docs) {
      print("i am here");
      print(snapshot.data());
    }
  }

  @override
  Widget build(BuildContext context) {
    final entriesProvider = Provider.of<UserDataProvider>(context);
    final userProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);

    // String response = "";
    bool isUserEntriesEmpty;
    // print("check");
    // print(entriesProvider.Userentries[0].age);
    if (entriesProvider.Userentries.isNotEmpty) {
      isUserEntriesEmpty = false;
    } else {
      isUserEntriesEmpty = true;
    }
    // print(widget.steps);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Activity",
          style:
              Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25.0),
        ),
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      ),
      body: Column(
        children: [
          DataStream(),

          // Text("Current Date"),
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
                const Spacer(),
                Text(
                  DateFormat.yMMMd().format(_selectedDate).toString(),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    await presentDatePicker();
                    await entriesProvider.fetchEntries(
                        date_!, userProvider.user.email);
                    print("enter");

                    print(entriesProvider.Userentries.length);
                    print("leave");
                  },
                  icon: const Icon(Icons.calendar_month),
                  iconSize: 45.0,
                )
              ],
            ),
          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              children: [
                CustomBlocks(
                  title: "Weight",
                  icon: Icons.monitor_weight,
                  imageUrl: "url",
                  value: isUserEntriesEmpty
                      ? "0"
                      : "${entriesProvider.Userentries[0].weight} KG",
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                CustomBlocks(
                  title: "Sleep",
                  icon: Icons.bedtime,
                  imageUrl: "url",
                  value: isUserEntriesEmpty
                      ? "0"
                      : "${entriesProvider.Userentries[0].sleep} HRS",
                  // color: Colors.yellow,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                CustomBlocks(
                  title: "Water",
                  icon: Icons.water_drop,
                  imageUrl: "",
                  value: isUserEntriesEmpty
                      ? "0"
                      : "${entriesProvider.Userentries[0].water} GLASS",
                  // color: Colors.green,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                CustomBlocks(
                  title: "Walk",
                  icon: Icons.directions_walk,
                  imageUrl: "",
                  value: "${widget.steps} STEPS",
                  // color: Colors.pink,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
