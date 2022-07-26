// ignore_for_file: depend_on_referenced_packages, unused_local_variable, avoid_returning_null_for_void, use_build_context_synchronously

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:smarthome/Screens/Authentication/Auth_Main/authmain.dart';
import '../../../../Logic/Modules/userData_model.dart';
import '../../../../Logic/Providers/userData_provider.dart';
import '../../../../Logic/Services/auth_services/auth_service.dart';
import '../../../Splash/splashscreen.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final _formkey = GlobalKey<FormState>();
  late File imageFile;
  PlatformFile? pickedFile;
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    User user = authService.getcurrentUser();
    List<UserData> userDataList = [];
    final userprovider = Provider.of<UsereDataProvider>(context);
    final userDataListRaw = Provider.of<List<UserData>?>(context);
    userDataListRaw?.forEach((element) {
      if (user.uid == element.id) {
        userDataList.add(element);
      } else {
        return null;
      }
    });
    UserData? userData;
    const padd = EdgeInsets.only(left: 28, right: 30, top: 8, bottom: 5);
    return Form(
      key: _formkey,
      child: Stack(
        children: [
          const BackgroundImage(),
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            "My ",
                            style: GoogleFonts.cormorantGaramond(
                              textStyle: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Profile",
                            style: GoogleFonts.cormorantGaramond(
                              textStyle: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 10),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "You are an active user.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    selectFile();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 110,
                                      width: 110,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: pickedFile != null
                                                ? FileImage((File(
                                                    "${pickedFile!.path}")))
                                                : NetworkImage(userDataList
                                                        .first.userimage)
                                                    as ImageProvider,
                                          )),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userDataList.first.Name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "User ID : ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        userprovider.deleteUserData(user.uid);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AuthMain()));
                                      },
                                      child: const Text(
                                        "Remove",
                                        style: TextStyle(color: Colors.pink),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(),
                            const Padding(
                              padding: EdgeInsets.only(left: 28.0, top: 10),
                              child: Text(
                                "Name",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: padd,
                              child: SizedBox(
                                  height: 50,
                                  width: 325,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      // userprovider.changeName(value);
                                      userprovider.changeName(value);
                                    },
                                    initialValue: userDataList.first.Name,
                                    obscureText: false,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    cursorColor: Colors.grey,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 17),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 8, top: 12),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          'assets/images/userimages.png',
                                          width: 20,
                                          height: 20,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 28.0, top: 10),
                              child: Text(
                                "Email",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: padd,
                              child: SizedBox(
                                  height: 50,
                                  width: 325,
                                  child: TextFormField(
                                    readOnly: true,
                                    onChanged: ((value) {
                                      user.updateEmail(value);
                                      userprovider.changeEmail(value);
                                    }),
                                    initialValue: userDataList.first.Email,
                                    obscureText: false,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: Colors.grey,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 17),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 8, top: 12),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          'assets/images/email.png',
                                          width: 20,
                                          height: 20,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 28.0, top: 10),
                              child: Text(
                                "Phone Number",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: padd,
                              child: SizedBox(
                                height: 50,
                                width: 325,
                                child: TextFormField(
                                  onChanged: ((value) {
                                    userprovider.changephonenumber(value);
                                  }),
                                  initialValue:
                                      userDataList.first.phoneNumber != "null"
                                          ? userDataList.first.phoneNumber
                                          : "",
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.phone,
                                  cursorColor: Colors.grey,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 17),
                                  decoration: InputDecoration(
                                    hintText: "Phone Number",
                                    contentPadding:
                                        const EdgeInsets.only(left: 8, top: 12),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        'assets/images/phonelist.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  showLoading = true;
                                });
                                progressIndicater(context, showLoading = true);
                                if (pickedFile != null) {
                                  final ref = FirebaseStorage.instance
                                      .ref()
                                      .child('profileImg')
                                      .child(pickedFile!.name.toString());
                                  await ref.putFile(imageFile);
                                  String url = await ref.getDownloadURL();
                                  userprovider.changeUserimage(url);
                                  userprovider.updateProfileImg(user.uid);
                                  userprovider.upadateusername(user.uid);
                                  userprovider.upadatuserphonenumber(user.uid);
                                } else {
                                  userprovider.upadateusername(user.uid);
                                  userprovider.upadatuserphonenumber(user.uid);
                                }

                                setState(() {
                                  showLoading = false;
                                  pickedFile = null;
                                });
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xff339DFA),
                                          Color(0xff0367CC),
                                        ],
                                        stops: [0.0, 1.0],
                                        begin: FractionalOffset.centerLeft,
                                        end: FractionalOffset.centerRight,
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      SizedBox(width: 25),
                                      VerticalDivider(
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 15),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;

      if (pickedFile != null) {
        imageFile = File(pickedFile!.path!);
      }
    });
  }

  Future<dynamic>? progressIndicater(BuildContext context, showLoading) {
    if (showLoading == true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    } else {
      return null;
    }
  }
}
