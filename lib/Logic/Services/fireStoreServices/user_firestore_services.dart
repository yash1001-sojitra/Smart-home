// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Modules/userData_model.dart';

class UserDataFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUser(UserData userData) {
    return _db.collection('User').doc(userData.id).set(userData.createMap());
  }

  Stream<List<UserData>> getUserData() {
    return _db
        .collection('User')
        .orderBy("time", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => UserData.fromFirestore(document.data()))
            .toList());
  }

  Future<UserData?> getUserDataFromUId(uid) async {
    UserData? userdata;
    await _db.collection('User').doc(uid).get().then((value) {
      userdata = UserData.fromFirestore(value.data());
    });
    return userdata;
  }

  Future<void> upadateProfileImg(String url, String studentntID) {
    return _db.collection('User').doc(studentntID).set(
      {'UserImage': url},
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<void> removeUser(String userId) {
    return _db.collection('User').doc(userId).delete();
  }
}
