// ignore_for_file: non_constant_identifier_names, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smarthome/Logic/Services/fireStoreServices/user_firestore_services.dart';
import '../Modules/userData_model.dart';

class UsereDataProvider with ChangeNotifier {
  final service = UserDataFirestoreService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

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

  // bool _hasError = false;
  // bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

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
  //   final GoogleSignInAccount? googleSignInAccount =
  //       await googleSignIn.signIn();

  //   if (googleSignInAccount != null) {
  //     // executing our authentication
  //     try {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );

  //       // signing to firebase user instance

  //       saveUserData();
  //       notifyListeners();
  //     } on FirebaseAuthException catch (e) {
  //       switch (e.code) {
  //         case "account-exists-with-different-credential":
  //           _errorCode =
  //               "You already have an account with us. Use correct provider";
  //           _hasError = true;
  //           notifyListeners();
  //           break;

  //         case "null":
  //           _errorCode = "Some unexpected error while trying to sign in";
  //           _hasError = true;
  //           notifyListeners();
  //           break;
  //         default:
  //           _errorCode = e.toString();
  //           _hasError = true;
  //           notifyListeners();
  //       }
  //     }
  //   } else {
  //     _hasError = true;
  //     notifyListeners();
  //   }
  // }

}
