// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smarthome/Core/Constant/string.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text("Logout"),
          onPressed: () {
            auth.signOut();
            Navigator.popUntil(context, (route) => false);
            Navigator.pushNamed(context, authmainScreenRoute);
          },
        ),
      ),
    );
  }
}
