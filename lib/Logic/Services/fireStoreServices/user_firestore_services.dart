// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

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

  Future<void> upadateProfileImg(String url, String ID) {
    return _db.collection('User').doc(ID).set(
      {'UserImage': url},
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<void> removeUser(String userId) {
    return _db.collection('User').doc(userId).delete();
  }

  Future<void> addotheruser(String userId, String otherId) {
    return _db.collection('User').doc(userId).update({
      'OtherUser': FieldValue.arrayUnion([otherId])
    });
  }

  Future<void> removeotheruser(String userId, String otherId) {
    return _db.collection('User').doc(userId).update({
      'OtherUser': FieldValue.arrayRemove([otherId])
    });
  }
}
