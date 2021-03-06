import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: const <TextSpan>[
        TextSpan(
            text: 'Flutter',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                decoration: TextDecoration.none)),
        TextSpan(
            text: 'Blog',
            style: TextStyle(
                color: Colors.lightGreen,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
      ],
    ),
  );
}

Widget appBar2(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: const <TextSpan>[
        TextSpan(
            text: 'Make Your Blog',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                decoration: TextDecoration.none)),
      ],
    ),
  );
}
