// ignore_for_file: file_names, non_constant_identifier_names

class UserData {
  String id;
  String Name;
  String email;
  String phonenumber;
  String userimage;
  DateTime time;
  UserData(
      {required this.id,
      required this.Name,
      required this.email,
      required this.phonenumber,
      required this.userimage,
      required this.time});

  Map<String, dynamic> createMap() {
    return {
      'id': id,
      'Name': Name,
      'Email': email,
      'Phonenumber' : phonenumber,
      'UserImage': userimage,
      'time': time,
    };
  }

  UserData.fromFirestore(Map<String, dynamic>? firestoreMap)
      : id = firestoreMap!['id'],
        Name = firestoreMap['Name'],
        email = firestoreMap['Email'],
        phonenumber = firestoreMap['Phonenumber'],
        userimage = firestoreMap['UserImage'],
        time = firestoreMap['time'].toDate();
}
