import 'dart:developer' as devtools show log;

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import 'globals.dart';

void showSnackBar(
  String text, {
  Duration duration = const Duration(seconds: 2),
}) {
  Globals.scaffoldMessengerKey.currentState
    ?..clearSnackBars()
    ..showSnackBar(
      SnackBar(content: Text(text), duration: duration),
    );
}

bool isNullOrBlank(String? data) => data?.trim().isEmpty ?? true;

void log(
  String screenId, {
  dynamic msg,
  dynamic error,
  StackTrace? stackTrace,
}) =>
    devtools.log(
      msg.toString(),
      error: error,
      name: screenId,
      stackTrace: stackTrace,
    );

animationsnackbar(String title, String message) {
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: ContentType.failure,
    ),
  );
  return snackBar;
}
