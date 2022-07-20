// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/cupertino.dart';
import 'package:smarthome/Logic/Services/fireStoreServices/user_firestore_services.dart';

import '../modules/userData_model.dart';

class UsereDataProvider with ChangeNotifier {
  final service = UserDataFirestoreService();
  late String _id;
  late String _Name;
  late String _email;
  String _userimage =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
  final DateTime _time = DateTime.now();

  // getter
  String get getId => _id;
  String get getName => _Name;
  String get getEmail => _email;
  String get getUserimage => _userimage;

  // setter
  void changeId(String value) {
    _id = value;
  }

  void changeName(String value) {
    _Name = value;
  }

  void changeEmail(String value) {
    _email = value;
  }

  void changeUserimage(String value) {
    _userimage = value;
  }

  void saveUserData() {
    var newUserData = UserData(
        email: getEmail,
        Name: getName,
        id: getId,
        userimage: getUserimage.isEmpty ? '' : getUserimage,
        time: _time);
    service.saveUser(newUserData);
  }

  void deleteUserData(userId) {
    service.removeUser(userId);
  }

  void updateProfileImg(studentntID) {
    service.upadateProfileImg(_userimage, studentntID);
  }
}
