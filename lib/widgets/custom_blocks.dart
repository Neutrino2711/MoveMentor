import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CustomBlocks extends StatelessWidget {
  const CustomBlocks({
    super.key,
    required this.title,
    required this.icon,
    required this.imageUrl,
    required this.value,
    required this.color,
  });

  final String title, imageUrl, value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
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
          color: Theme.of(context).colorScheme.onInverseSurface,
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
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
