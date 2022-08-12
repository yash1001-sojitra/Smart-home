// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class GradientWrapper extends StatelessWidget {
  final Widget child;
  Color mainColor;

  GradientWrapper({Key? key, required this.child, required this.mainColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
            stops: [0.1, 0.3, 0.7, 0.9],
            colors: [
              Color.fromARGB(255, 40, 53, 147),
              Color.fromARGB(255, 63, 81, 181),
              Color.fromARGB(255, 92, 107, 192),
              Color.fromARGB(255, 121, 134, 203),
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
