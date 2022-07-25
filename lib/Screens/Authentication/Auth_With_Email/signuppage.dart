// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:smarthome/Core/Constant/string.dart';
import 'package:smarthome/Core/Constant/textcontroller.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../Logic/Providers/userData_provider.dart';
import '../../../Logic/Services/auth_services/auth_service.dart';
import '../../../Logic/Modules/user_model.dart';
import '../../Splash/splashscreen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late AuthService authService;
  bool showLoading = false;
  bool showAlert = false;
  bool ispasswordvisible = true;
  String? phoneNumber;

  final _form = GlobalKey<FormState>();

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    authService = Provider.of<AuthService>(context);
    final userDataProvider = Provider.of<UsereDataProvider>(context);

    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Form(
              key: _form,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.cormorantGaramond(
                          textStyle: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        width: 325,
                        child: TextField(
                          onChanged: (((value) =>
                              userDataProvider.changeName(value))),
                          obscureText: false,
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white54,
                            ),
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        )),
                    const SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        width: 325,
                        child: TextField(
                          onChanged: (((value) =>
                              userDataProvider.changeEmail(value))),
                          obscureText: false,
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white54,
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        )),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18),
                      child: IntlPhoneField(
                        dropdownTextStyle: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                        invalidNumberMessage: 'Invalid Phone Number!',
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (phone) {
                          phoneNumber = phone.completeNumber;
                          userDataProvider
                              .changephonenumber(phoneNumber.toString());
                        },
                        initialCountryCode: 'IN',
                        flagsButtonPadding: const EdgeInsets.only(right: 10),
                        showDropdownIcon: true,
                        dropdownIcon:
                            Icon(color: Colors.white, Icons.arrow_drop_down),
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        width: 325,
                        child: TextField(
                          cursorColor: Colors.white,
                          controller: passwordController,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17),
                          obscureText: ispasswordvisible,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white54,
                            ),
                            suffixIcon: IconButton(
                              icon: ispasswordvisible
                                  ? const Icon(
                                      Icons.visibility_off,
                                      size: 20,
                                      color: Colors.white54,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      size: 20,
                                      color: Colors.white54,
                                    ),
                              onPressed: () => setState(
                                  () => ispasswordvisible = !ispasswordvisible),
                            ),
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    const SizedBox(height: 25),
                    Container(
                      width: 325,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white),
                        color: Colors.black45,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          _saveForm();
                          setState(() {
                            showLoading = true;
                          });
                          progressIndicater(context, showLoading = true);
                          FireBaseUser? user = await createUser();
                          userDataProvider.changeId(user!.uid);
                          userDataProvider.saveUserData();
                          showAlert == true
                              ? null
                              : progressIndicater(context, showLoading = true);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an Account?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 5)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, singInScreenRoute);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
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

  createUser() async {
    try {
      FireBaseUser? user = await authService.createUserWithEmailAndPassword(
          emailController.text.toString(), passwordController.text.toString());

      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, singInScreenRoute);
      return user;
    } catch (e) {
      return alertBox(context, e);
    }
  }

  Future<void> alertBox(BuildContext context, e) {
    setState(() {
      showLoading = false;
      showAlert = true;
    });
    return Alert(
      context: context,
      padding: const EdgeInsets.only(left: 10, right: 10),
      title: "ALERT",
      style: const AlertStyle(
        descTextAlign: TextAlign.center,
      ),
      desc: e.toString(),
    ).show();
  }
}
