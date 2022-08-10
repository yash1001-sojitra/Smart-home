// ignore_for_file: non_constant_identifier_names, file_names, empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  void addotheruser(userId, otherId) {
    service.addotheruser(userId, otherId);
  }

  void removeotheruser(userId, otherId) {
    service.removeotheruser(userId, otherId);
  }

  void saveUserData() {
    var userData = UserData(
        Email: getEmail,
        Name: getName,
        phoneNumber: getphonenumber,
        id: getId,
        userimage: getUserimage.isEmpty ? '' : getUserimage,
        otheruser: [],
        time: _time);
    service.saveUser(userData);
  }

  void deleteUserData(userId) {
    service.removeUser(userId);
  }

  void updateProfileImg(userID) {
    service.upadateProfileImg(_userimage, userID);
  }

  void upadateusername(userID) {
    service.upadateusername(_Name, userID);
  }

  void upadatuserphonenumber(userID) {
    service.upadateuserphonenumber(_phonenumber, userID);
  }

  Future signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        String userid = user!.uid.toString();
        String email = user.email.toString();
        String name = user.displayName.toString();
        String photourl = user.photoURL.toString();
        String phonenumber = user.phoneNumber.toString();
        String userdbid = UsereDataProvider().getId;
        if (userdbid == userid) {
        } else {
          changeId(userid);
          changeEmail(email);
          changeName(name);
          changeUserimage(photourl);
          changephonenumber(phonenumber);
          saveUserData();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
        } else if (e.code == 'invalid-credential') {}
      } catch (e) {}
    }
  }
}
