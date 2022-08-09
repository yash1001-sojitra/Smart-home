import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Authentication/Auth_Main/authmain.dart';

class SettingDash extends StatefulWidget {
  const SettingDash({Key? key}) : super(key: key);

  @override
  State<SettingDash> createState() => _SettingDashState();
}

class _SettingDashState extends State<SettingDash> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: const Icon(Icons.signpost_outlined),
            onTap: () {
              _signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AuthMain();
                  },
                ),
              );
            }),
      ),
    );
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
