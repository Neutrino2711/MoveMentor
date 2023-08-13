import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:status_code0/widgets/custom_blocks.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:status_code0/models/api_integrate.dart';
import 'package:status_code0/models/data_stream.dart';
import 'package:firebase_core/firebase_core.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    // ApiIntegrate _apiIntegrate =
    //     ApiIntegrate(Sleep: widget.sleep, Steps: widget.steps);
    // _apiIntegrate.api_inte();
    super.initState();
  }

  List<Map<String, dynamic>>? data;

  @override
  Widget build(BuildContext context) {
    String response = "";

    print(widget.steps);
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
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              DataStream(),
              // IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.8,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                      value: "${widget.weight} KG",
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    CustomBlocks(
                      title: "Sleep",
                      icon: Icons.bedtime,
                      imageUrl: "url",
                      value: "${widget.sleep} HRS",
                      // color: Colors.yellow,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    CustomBlocks(
                      title: "Water",
                      icon: Icons.water_drop,
                      imageUrl: "",
                      value: "${widget.water} GLASS",
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
        ),
      ),
    );
  }
}
