import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:firebase_core/firebase_core.dart';

class DataStream extends StatelessWidget {
  DataStream({super.key});

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
          stream: _firestore.collection('features').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data_value = snapshot.data!.docs;
              List<int> weights = [];
              List<String> dates = [];
              for (var data in data_value) {
                final _weight = data.data();
                weights.add((_weight['Weight']));
                dates.add((_weight['Date']));
              }

              // List<String> stringList = ['apple', 'banana', 'cherry'];
              // List<int> intList = [1, 2, 3];

              List<_ChartData> twoDList = [];

              for (int i = 0; i < dates.length; i++) {
                var flag = _ChartData(dates[i], weights[i]);
                twoDList.add(flag);
              }

              return SfCartesianChart(

                  // data: ,

                  primaryXAxis: CategoryAxis(),
                  primaryYAxis:
                      NumericAxis(minimum: 1, maximum: 110, interval: 1),
                  series: <ChartSeries<_ChartData, String>>[
                    ColumnSeries<_ChartData, String>(
                        dataSource: twoDList,
                        xValueMapper: (_ChartData twoDList, _) => twoDList.x,
                        yValueMapper: (_ChartData twoDList, _) => twoDList.y,
                        name: 'Gold',
                        color: Theme.of(context).colorScheme.inversePrimary)
                  ]);
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            }
          }),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String? x;
  final int? y;
}
