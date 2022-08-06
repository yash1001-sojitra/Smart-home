// ignore_for_file: non_constant_identifier_names, file_names, empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smarthome/Logic/Modules/user_model.dart';
import 'package:smarthome/Logic/Services/auth_services/auth_service.dart';
import 'package:smarthome/Logic/Services/fireStoreServices/user_firestore_services.dart';
import '../Modules/userData_model.dart';

class UsereDataProvider with ChangeNotifier {
  final service = UserDataFirestoreService();

  late String _id;
  late String _Name;
  late String _email;
  late String _phonenumber;
  String _userimage =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
  final DateTime _time = DateTime.now();

  // getter
  String get getId => _id;
  String get getName => _Name;
  String get getEmail => _email;
  String get getphonenumber => _phonenumber;
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

  void changephonenumber(String value) {
    _phonenumber = value;
  }

  void changeUserimage(String value) {
    _userimage = value;
  }

  void saveUserData() {
    var userData = UserData(
        email: getEmail,
        Name: getName,
        phonenumber: getphonenumber,
        id: getId,
        userimage: getUserimage.isEmpty ? '' : getUserimage,
        time: _time);
    service.saveUser(userData);
  }

  void deleteUserData(userId) {
    service.removeUser(userId);
  }

  void updateProfileImg(studentntID) {
    service.upadateProfileImg(_userimage, studentntID);
  }

  // Future signInWithGoogle() async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   final GoogleSignInAccount? googleSignInAccount =
  //       await googleSignIn.signIn();

  //   final User? user = auth.currentUser;
  //   final uid = user!.uid;
  //   _id = uid;
  //   _Name = googleSignInAccount!.displayName.toString();
  //   _email = googleSignInAccount.email;
  //   _phonenumber = "";
  //   _userimage = googleSignInAccount.photoUrl.toString();
  //   changeId(_id);
  //   changeEmail(_email);
  //   changeName(_Name);
  //   changeUserimage(_userimage);
  //   changephonenumber(_phonenumber);
  //   saveUserData();
  //   notifyListeners();
  // }
}
