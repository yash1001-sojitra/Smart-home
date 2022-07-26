import 'package:flutter/material.dart';
// import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AcViewModel extends StatelessWidget {
  const AcViewModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SleekCircularSlider(
        //   appearance: CircularSliderAppearance(
        //       customWidths: CustomSliderWidths(progressBarWidth: 10)),
        //   min: 16,
        //   max: 30,
        //   initialValue: 29,
        // )
        Image.asset(
          "assets/images/wheel.png",
        ),
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
}
