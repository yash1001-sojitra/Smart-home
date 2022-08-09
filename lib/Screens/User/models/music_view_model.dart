// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'dart:math' as math;

class MusicViewModel extends StatefulWidget {
  const MusicViewModel({Key? key}) : super(key: key);

  @override
  State<MusicViewModel> createState() => _MusicViewModelState();
}

class _MusicViewModelState extends State<MusicViewModel>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 7));
  double initval = 0;
  bool isplay = false;
  bool isPlayerconnected = false;

  @override
  void initState() {
    super.initState();
    isplay = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Stack(children: [
          Positioned(
            top: 15,
            left: 15,
            child: AnimatedBuilder(
              animation: animationController,
              child: const CircleAvatar(
                radius: 75,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/musicimage.jpg"),
                  radius: 80,
                ),
              ),
              builder: (BuildContext context, Widget? widget) {
                return Transform.rotate(
                  angle: animationController.value * 6.3,
                  child: widget,
                );
              },
            ),
          ),
          SleekCircularSlider(
            appearance: CircularSliderAppearance(
                size: 180,
                customWidths:
                    CustomSliderWidths(trackWidth: 6, progressBarWidth: 12),
                customColors: CustomSliderColors(
                  dotColor: Colors.black,
                  progressBarColor: Colors.white,
                  hideShadow: true,
                  trackColor: Colors.blue,
                )),
            min: 0,
            max: 5,
            initialValue: initval,
            onChange: (double value) {
              setState(() {
                initval = value;
              });
            },
            // onChangeStart: (double startValue) {},
            // onChangeEnd: (double endValue) {},
            innerWidget: (double value) {
              return Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Row(
                  children: const [
                    Text(
                      "00:00",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      " / ",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      "04:50",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ],
                ),
              );
            },
          ),
        ]),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Harman Kardon",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                  ),
                  Text(
                    "Connected",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              CupertinoSwitch(
                activeColor: Colors.blue,
                trackColor: Colors.grey,
                thumbColor: isPlayerconnected ? Colors.white : Colors.white,
                value: isPlayerconnected,
                onChanged: (value) {
                  setState(() {
                    isPlayerconnected = value;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: 180 * math.pi / 180,
              child: const IconButton(
                icon: Icon(Icons.play_arrow, color: Colors.black),
                onPressed: null,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/musicimage.jpg"),
                    radius: 80,
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 4.5,
                  child: GestureDetector(
                    onTap: () {
                      if (isPlayerconnected == true) {
                        if (isplay == true) {
                          setState(() {
                            isplay = false;
                            animationController.repeat();
                          });
                        } else {
                          setState(() {
                            isplay = true;
                            animationController.stop();
                          });
                        }
                      }
                    },
                    child: IconButton(
                        onPressed: null,
                        icon: Icon(
                          isplay ? Icons.play_arrow : Icons.pause,
                          size: 35,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            const IconButton(
              icon: Icon(Icons.play_arrow, color: Colors.black),
              onPressed: null,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Lose Yourself",
          style: TextStyle(fontSize: 17),
        )
      ],
    );
  }
}
