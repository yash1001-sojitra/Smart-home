import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightViewModel extends StatefulWidget {
  const LightViewModel({Key? key}) : super(key: key);

  @override
  State<LightViewModel> createState() => _LightViewModelState();
}

class _LightViewModelState extends State<LightViewModel> {
  double init = 50.0;
  bool isLightconnected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 230,
          child: Stack(children: [
            Positioned(
              bottom: 22,
              right: 50,
              child: Center(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
            Image.asset(
              "assets/images/roomlight.png",
            ),
          ]),
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
                    "Philips Lamp",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 23),
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
                thumbColor: isLightconnected ? Colors.white : Colors.white,
                value: isLightconnected,
                onChanged: (value) {
                  setState(() {
                    isLightconnected = value;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text("Intensity"),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                SliderTheme(
                    data: SliderThemeData(
                        trackHeight: 60,
                        thumbShape: SliderComponentShape.noOverlay,
                        overlayShape: SliderComponentShape.noOverlay,
                        valueIndicatorShape: SliderComponentShape.noOverlay,
                        trackShape: const RectangularSliderTrackShape()),
                    child: Slider(
                      activeColor: Colors.white70,
                      inactiveColor: Colors.grey,
                      value: init.toDouble(),
                      min: 0.0,
                      max: 100.0,
                      onChanged: (value) {
                        setState(() {
                          init = value;
                        });
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        CupertinoIcons.brightness_solid,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${init.toInt()}%",
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        CupertinoIcons.brightness_solid,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
