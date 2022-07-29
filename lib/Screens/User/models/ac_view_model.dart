// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../other/AC_Slider/circle_slider.dart';

class AcViewModel extends StatefulWidget {
  const AcViewModel({Key? key}) : super(key: key);

  @override
  State<AcViewModel> createState() => _AcViewModelState();
}

class _AcViewModelState extends State<AcViewModel> {
  bool showLoading = false;
  bool showAlert = false;
  var initval = 29;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CircleSlider(
            maxValue: 30,
            value: initval,
            onChanged: (value) {
              setState(() {
                initval = value;
              });
            },
          ),
        ]),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Samsung AC",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 23),
                ),
                Text(
                  "Connected",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        // Call when you want to show the time picker

        GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff339DFA),
                      Color(0xff0367CC),
                    ],
                    stops: [0.0, 1.0],
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "SET TEMPERATURE",
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, letterSpacing: 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> alertBox(BuildContext context, e) {
    setState(() {
      showLoading = false;
      showAlert = true;
    });
    return Alert(
      context: context,
      title: "ALERT",
      desc: e.toString(),
    ).show();
  }
}
