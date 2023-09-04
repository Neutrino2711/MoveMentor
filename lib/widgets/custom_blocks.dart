import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:provider/provider.dart';
import 'package:status_code0/models/user_data.dart';

class CustomBlocks extends StatelessWidget {
  const CustomBlocks({
    super.key,
    required this.title,
    required this.icon,
    required this.imageUrl,
    required this.value,
    required this.color,
    required this.isWater,
    required this.isSleep,
    required this.isWeight,
    required this.isStep,
  });

  final int value;
  final String title, imageUrl;
  final IconData icon;
  final Color color;
  final bool isWeight, isWater, isSleep, isStep;
  @override
  Widget build(BuildContext context) {
    final detailsProvider = Provider.of<UserDataProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: isSleep
            ? BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [
                //     Theme.of(context).colorScheme.onPrimaryContainer,
                //     // Theme.of(context).colorScheme.onPrimary,
                //     Theme.of(context).colorScheme.onPrimary,
                //     // Theme.of(context).colorScheme.onPrimaryContainer,
                //     // color.withOpacity(0.66),
                //     // color.withOpacity(0.55),
                //   ],
                //   // begin: Alignment.bottomRight,
                //   // end: Alignment.topLeft,
                // ),
                color: value >= 8
                    ? Colors.greenAccent
                    : Theme.of(context).colorScheme.inversePrimary,

                borderRadius: BorderRadius.circular(20.0),
              )
            : isWater
                ? BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [
                    //     Theme.of(context).colorScheme.onPrimaryContainer,
                    //     // Theme.of(context).colorScheme.onPrimary,
                    //     Theme.of(context).colorScheme.onPrimary,
                    //     // Theme.of(context).colorScheme.onPrimaryContainer,
                    //     // color.withOpacity(0.66),
                    //     // color.withOpacity(0.55),
                    //   ],
                    //   // begin: Alignment.bottomRight,
                    //   // end: Alignment.topLeft,
                    // ),
                    color: value > 7
                        ? Colors.greenAccent
                        : Theme.of(context).colorScheme.inversePrimary,

                    borderRadius: BorderRadius.circular(20.0),
                  )
                : isWeight
                    ? BoxDecoration(
                        // gradient: LinearGradient(
                        //   colors: [
                        //     Theme.of(context).colorScheme.onPrimaryContainer,
                        //     // Theme.of(context).colorScheme.onPrimary,
                        //     Theme.of(context).colorScheme.onPrimary,
                        //     // Theme.of(context).colorScheme.onPrimaryContainer,
                        //     // color.withOpacity(0.66),
                        //     // color.withOpacity(0.55),
                        //   ],
                        //   // begin: Alignment.bottomRight,
                        //   // end: Alignment.topLeft,
                        // ),
                        color: value > 85
                            ? Colors.green
                            : Theme.of(context).colorScheme.inversePrimary,

                        borderRadius: BorderRadius.circular(20.0),
                      )
                    : BoxDecoration(
                        // gradient: LinearGradient(
                        //   colors: [
                        //     Theme.of(context).colorScheme.onPrimaryContainer,
                        //     // Theme.of(context).colorScheme.onPrimary,
                        //     Theme.of(context).colorScheme.onPrimary,
                        //     // Theme.of(context).colorScheme.onPrimaryContainer,
                        //     // color.withOpacity(0.66),
                        //     // color.withOpacity(0.55),
                        //   ],
                        //   // begin: Alignment.bottomRight,
                        //   // end: Alignment.topLeft,
                        // ),
                        color: Theme.of(context).colorScheme.inversePrimary,

                        borderRadius: BorderRadius.circular(20.0),
                      ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Icon(
                  icon,
                  size: 30.0,
                ),
              ],
            ),
            // SizedBox(
            //   height: 60,
            //   child: SfRadialGauge(
            //     axes: [
            //       RadialAxis(
            //         minimum: 0,
            //         maximum: 15,
            //         ranges: [],
            //         radiusFactor: 0.2,
            //       )
            //     ],
            //   ),
            // ),
            isWeight
                ? Text(
                    "$value KG",
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                : isSleep
                    ? Text(
                        "$value HOURS",
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    : isWater
                        ? Text(
                            "$value GLASS",
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        : isStep
                            ? Text(
                                "$value STEPS",
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            : Text(
                                "NO DATA",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
          ],
        ),
      ),
    );
  }
}
