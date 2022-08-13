// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationService {
  static final localAuth = LocalAuthentication();
  final _storage = const FlutterSecureStorage();
  final StreamController<bool> _isEnabledController =
      StreamController<bool>.broadcast();
  final StreamController<bool> _isNewUserController =
      StreamController<bool>.broadcast();

  StreamController<bool> get isEnabledController => _isEnabledController;
  StreamController<bool> get isNewUserController => _isNewUserController;

  Stream<bool> get isEnabledStream => _isEnabledController.stream;
  Stream<bool> get isNewUserStream => _isNewUserController.stream;

  Future<String> read(String key) async {
    final val = await _storage.read(key: key);
    return val != null ? jsonDecode(val) : '';
  }

  Future<void> clearStorage() async {
    _storage.delete(key: 'pin');
  }

  Future<void> write(String key, dynamic value) async {
    await _storage.write(key: key, value: jsonEncode(value));
  }

  Future<void> verifyCode(String enteredCode) async {
    final pin = await read('pin');
    if (pin == enteredCode) {
      isNewUserController.add(false);
    } else {
      isNewUserController.add(true);
      write('pin', enteredCode);
    }
    isEnabledController.add(true);
  }

  dispose() {
    _isEnabledController.close();
    _isNewUserController.close();
  }
}

final AuthenticationService authService = AuthenticationService();
final localAuth = AuthenticationService.localAuth;
