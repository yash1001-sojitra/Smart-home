// ignore_for_file: file_names, non_constant_identifier_names

class UserData {
  String id;
  String Name;
  String Email;
  String phoneNumber;
  String userimage;
  List otheruser;
  DateTime time;
  UserData(
      {required this.id,
      required this.Name,
      required this.Email,
      required this.phoneNumber,
      required this.userimage,
      required this.otheruser,
      required this.time});

  Map<String, dynamic> createMap() {
    return {
      'id': id,
      'Name': Name,
      'Email': Email,
      'PhoneNumber': phoneNumber,
      'UserImage': userimage,
      'OtherUser': otheruser,
      'time': time,
    };
  }

  UserData.fromFirestore(Map<String, dynamic>? firestoreMap)
      : id = firestoreMap!['id'],
        Name = firestoreMap['Name'],
        Email = firestoreMap['Email'],
        phoneNumber = firestoreMap['PhoneNumber'],
        userimage = firestoreMap['UserImage'],
        otheruser = firestoreMap['OtherUser'],
        time = firestoreMap['time'].toDate();
}
