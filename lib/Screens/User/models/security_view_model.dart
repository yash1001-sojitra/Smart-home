import 'package:flutter/material.dart';

class SecurityViewModel extends StatefulWidget {
  const SecurityViewModel({Key? key}) : super(key: key);

  @override
  State<SecurityViewModel> createState() => _SecurityViewModelState();
}

class _SecurityViewModelState extends State<SecurityViewModel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
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
                  "MI Security Cam",
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
                    "LOCK",
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
