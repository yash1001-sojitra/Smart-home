// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smarthome/Core/Constant/string.dart';

import '../Passcode_and_fingerprint/service/AuthenticationService.dart';
import '../Passcode_and_fingerprint/widget/gradientwrapper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _enabledFingerprint = false;

  void showBioMeteric() {
    localAuth.authenticate(localizedReason: 'Add Passcode?');
  }

  String get switchLabel => Platform.isIOS ? 'Face Id' : 'Touch Id';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GradientWrapper(
      mainColor: Colors.indigo,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: height * .3),
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            SwitchListTile(
              value: _enabledFingerprint,
              onChanged: (val) {
                setState(() => _enabledFingerprint = val);
                if (val) {
                  showBioMeteric();
                }
              },
              title: Text(
                'Enable $switchLabel',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white70,
                ),
              ),
              activeColor: Colors.green.shade200,
              secondary: const Icon(
                Icons.fingerprint,
              ),
            ),
            const SizedBox(height: 100),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, setpasscodeScreenRoute);
              },
              child: const Text(
                'Continue',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '* You could enable it also in settings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
