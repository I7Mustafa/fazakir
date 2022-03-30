import 'package:flutter/material.dart';

class ContantInfoApp extends StatelessWidget {
  const ContantInfoApp({Key? key, required this.title, required this.info})
      : super(key: key);
  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            info,
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}