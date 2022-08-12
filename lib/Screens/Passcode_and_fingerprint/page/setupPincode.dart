// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthome/Core/Constant/string.dart';

import '../service/AuthenticationService.dart';
import '../widget/passcode.dart';

class SetupPincode extends StatefulWidget {
  const SetupPincode({Key? key}) : super(key: key);

  @override
  _SetupPincodeState createState() => _SetupPincodeState();
}

class _SetupPincodeState extends State<SetupPincode> {
  late StreamController<bool> verficationController;

  void _onCallback(String enteredCode) {
    authService.verifyCode(enteredCode);
    authService.isEnabledStream.listen((isSet) {
      if (isSet) {
        Navigator.pushNamed(context, homepageScreenRoute);
      }
    });
  }

  void _onCancelCallBack() {
    // Should be disabled since you're already set the bio.

    return Navigator.pop(context);
  }

  @override
  void initState() {
    verficationController = authService.isEnabledController;
    super.initState();
  }

  @override
  void dispose() {
    verficationController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PasscodeWidget(
      verficationController.stream,
      _onCallback,
      _onCancelCallBack,
    );
  }
}
