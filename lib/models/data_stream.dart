import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:status_code0/models/google_signin.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DataStream extends StatelessWidget {
  DataStream({super.key});

  final _firestore = FirebaseFirestore.instance;

  int curr_month = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<GoogleSignInProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
          stream: _firestore
              .collection('features')
              .orderBy(
                'Date',
                descending: false,
              )
              .where('Id', isEqualTo: userProvider.user.email)
              .where(
                'Month',
                isEqualTo: curr_month,
              )

              // .orderBy('Date')
              // .orderBy('Date')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data_value = snapshot.data!.docs;
              List<int> weights = [];
              List<String> dates = [];
              for (var data in data_value) {
                final _weight = data.data();
                weights.add((_weight['Weight']));
                Timestamp timestamp = _weight['Date'];
                DateTime dateTime = timestamp.toDate();
                dates.add(DateFormat.yMMMd().format(dateTime));
                // dates.add(DateTime.parse(DateFormat.yMMMd()
                // .format(DateTime.parse(_weight['Date']))));
                // dates.add((_weight['Date']).toDate);
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
                      xValueMapper: (_ChartData twoDList, _) =>
                          twoDList.x.toString(),
                      yValueMapper: (_ChartData twoDList, _) {
                        return twoDList.y;
                      },
                      name: 'Gold',
                      color: Theme.of(context).colorScheme.inversePrimary,
                    )
                  ]);
            } else {
              print(snapshot.error);
              return const Center(
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
