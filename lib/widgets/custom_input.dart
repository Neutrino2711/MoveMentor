import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.label,
    required this.isWater,
    required this.water_controller,
  });

  final String label;
  final bool isWater;
  final TextEditingController water_controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 20.0),
          ),
          Spacer(),
          Expanded(
            child: isWater
                ? NumberInputPrefabbed.roundedEdgeButtons(
                    controller: water_controller,
                    incDecBgColor: Colors.white,
                    buttonArrangement: ButtonArrangement.incRightDecLeft,
                    onIncrement: ((newValue) => print(newValue)),
                    onDecrement: ((newValue) => print(newValue)),
                    style: TextStyle(color: Colors.black),
                    incIcon: Icons.add,
                    decIcon: Icons.remove,
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      )),
                    ),
                  ),

            // child: CupertinoPicker(
            //     itemExtent: 22, onSelectedItemChanged: null, children: value),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Glass"),
          ),
        ],
      ),
    );
  }
}
