import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passcode_screen/passcode_screen.dart';

// ignore: must_be_immutable
class PasscodeWidget extends StatefulWidget {
  PasscodeWidget(
      this.verficationStream, this.onPassCallback, this.onCancelCallback,
      {Key? key})
      : super(key: key);

  Stream<bool> verficationStream;
  Function(String) onPassCallback;
  void Function()? onCancelCallback;

  @override
  State<PasscodeWidget> createState() => _PasscodeWidgetState();
}

class _PasscodeWidgetState extends State<PasscodeWidget> {
  @override
  Widget build(BuildContext context) {
    return PasscodeScreen(
      shouldTriggerVerification: widget.verficationStream,
      title: const Text('Enter your passcode'),
      passwordEnteredCallback: widget.onPassCallback,
      deleteButton: const Text('Delete'),
      cancelButton: const Text('Cancel'),
      cancelCallback: widget.onCancelCallback,
      backgroundColor: Colors.indigo[200],
    );
  }
}
