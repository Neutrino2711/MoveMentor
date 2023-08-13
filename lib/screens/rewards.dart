import 'package:flutter/material.dart';

class RewardPage extends StatelessWidget {
  const RewardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios),
          backgroundColor: Colors.white,
          title: Text('Earn'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Challenge Board",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Collect badges and get rewarded",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Custom_Widget(
                    image_loc: 'images/welcome.png',
                    first_line: "Welcome",
                    sec_line: "300 Points",
                  ),
                  Custom_Widget(
                    image_loc: 'images/balloons.png',
                    first_line: "Birthday",
                    sec_line: "250 Points",
                  ),
                  Custom_Widget(
                    image_loc: 'images/badge.png',
                    first_line: "First Order",
                    sec_line: "300 Points",
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Custom_Widget(
                    image_loc: 'images/medal.png',
                    first_line: "Fifth Order",
                    sec_line: "500 Points",
                  ),
                  Custom_Widget(
                    image_loc: 'images/badge (1).png',
                    first_line: "Tenth Order",
                    sec_line: "1000 Points",
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class Custom_Widget extends StatelessWidget {
  const Custom_Widget(
      {super.key,
      required this.image_loc,
      required this.first_line,
      required this.sec_line});

  final String image_loc;
  final String first_line;
  final String sec_line;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 70.0, width: 70.0, child: Image.asset(image_loc)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(first_line),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(sec_line),
        )
      ],
    );
  }
}
