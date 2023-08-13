import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({this.text, this.url});

  final String? text;
  final String? url;
  // final int? index;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.14,
                // width: MediaQuery.sizeOf(context).width * 0.35,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(url!)),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                  // height: 250.0,
                  // height: MediaQuery.sizeOf(context).height * 0.14,
                  // width: MediaQuery.sizeOf(context).width * 0.40,
                  child: Column(
                children: [
                  Text(
                    text!,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                ],
              )),
            ),
          ],
        ),
        // trailing: Icon(Icons.arrow_forward_ios_outlined),
        // onTap: null,
      ),
    );
  }
}
