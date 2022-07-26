import 'package:flutter/material.dart';

class DevicesModel extends StatelessWidget {
  const DevicesModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.blue,
        child: SizedBox(
          height: 60,
          width: 72,
          child: Center(
            child: Image.asset("assets/images/light.png"),
          ),
        ),
      ),
    );
  }
}
