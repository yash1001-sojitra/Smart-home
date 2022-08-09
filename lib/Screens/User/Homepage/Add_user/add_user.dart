// ignore_for_file: depend_on_referenced_packages, unused_local_variable

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../Core/Constant/textcontroller.dart';
import '../../../../Logic/Modules/userData_model.dart';
import '../../../../Logic/Services/auth_services/auth_service.dart';
import '../../../Splash/splashscreen.dart';

class AdduserScreen extends StatefulWidget {
  const AdduserScreen({Key? key}) : super(key: key);

  @override
  State<AdduserScreen> createState() => _AdduserScreenPageState();
}

class _AdduserScreenPageState extends State<AdduserScreen> {
  final _formkey = GlobalKey<FormState>();
  late File imageFile;
  PlatformFile? pickedFile;
  bool showLoading = false;

  void _saveForm() {
    final isValid = _formkey.currentState?.validate();
    if (!isValid!) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserData? userData;
    final authService = Provider.of<AuthService>(context);
    User user = authService.getcurrentUser();
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
                            "Add ",
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
                            "User",
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
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: pickedFile != null
                                                ? FileImage(
                                                    (File(
                                                        "${pickedFile!.path}")),
                                                  )
                                                : const AssetImage(
                                                        "assets/images/profileimage.png")
                                                    as ImageProvider,
                                          )),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "User ID : ",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(),
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
                                    // initialValue: "yash",
                                    obscureText: false,
                                    controller: emailController,
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
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                Expanded(
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  " OR",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
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
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (value) {
                                      if (value!.length < 10 ||
                                          value.length > 10) {
                                        return "Please Enter Valid PhoneNumber";
                                      }

                                      return null;
                                    },
                                    obscureText: false,
                                    controller: phonenumberController,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.phone,
                                    cursorColor: Colors.grey,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 17),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 8, top: 12),
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
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                // _saveForm();
                                if (emailController.toString() == user.email) {
                                  
                                }
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "ADD USER",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
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
