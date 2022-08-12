// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:smarthome/Screens/Authentication/Auth_Main/authmain.dart';
import 'package:smarthome/Screens/User/Homepage/homepage.dart';

import '../service/AuthenticationService.dart';
import '../widget/gradientwrapper.dart';
import '../widget/passcode.dart';

class PasscodePage extends StatefulWidget {
  const PasscodePage({Key? key}) : super(key: key);

  @override
  _PasscodePageState createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage> {
  late Stream<bool> _isVerification;
  late Future<bool> hasBio;
  int attempts = 0;

  @override
  void initState() {
    authService.isEnabledStream;
    _isVerification = authService.isEnabledStream;
    super.initState();
  }

  void _onCallback(String enteredCode) {
    authService.verifyCode(enteredCode);
    _isVerification.listen((isValid) {
      if (isValid) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Homepage()));
      } else {
        setState(() => attempts += 1);
        if (attempts == 5) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AuthMain()));
        }
      }
    });
  }

  void _onCancel() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const AuthMain()));
  }

  Future<void> authenticate() async {
    final isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Do something',
        stickyAuth: true,
        useErrorDialogs: true);
    authService.isEnabledController.add(isAuthenticated);
    if (isAuthenticated) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Homepage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: localAuth.canCheckBiometrics,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            authenticate();
            return GradientWrapper(
              mainColor: Colors.indigo,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 75.0),
                child: const Text(
                  'Please Authenticate with Face ID',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
            );
          }
          return PasscodeWidget(
            _isVerification,
            _onCallback,
            _onCancel,
          );
        });
  }
}
