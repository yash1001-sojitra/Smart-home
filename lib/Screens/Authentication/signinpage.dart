// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:smarthome/Core/Constant/string.dart';
import 'package:smarthome/Core/Constant/textcontroller.dart';

import '../../Logic/Services/auth_services/auth_service.dart';
import '../Splash/splashscreen.dart';

class SignInpage extends StatefulWidget {
  const SignInpage({Key? key}) : super(key: key);

  @override
  State<SignInpage> createState() => _SignInpageState();
}

class _SignInpageState extends State<SignInpage> {
  late AuthService authService;
  bool showLoading = false;
  bool showAlert = false;
  bool ispasswordvisible = true;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    authService = Provider.of<AuthService>(context);

    return Form(
      key: _formkey,
      child: Stack(
        children: [
          const BackgroundImage(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 30, top: 50),
                      child: Text(
                        "Welcome",
                        style: GoogleFonts.cormorantGaramond(
                          textStyle: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Back!",
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
                        child: TextFormField(
                          controller: emailController,
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
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
                          ),
                        )),
                    const SizedBox(height: 30),
                    SizedBox(
                        height: 70,
                        width: 325,
                        child: TextFormField(
                          controller: passwordController,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          obscureText: ispasswordvisible,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Password";
                            } else if (value.length < 6) {
                              return "Password length must be 6";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
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
                    const SizedBox(height: 60),
                    Container(
                      width: 325,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.white),
                          color: Colors.black45),
                      child: TextButton(
                        onPressed: () async {
                          setState(() {
                            showLoading = true;
                          });
                          progressIndicater(context, showLoading = true);
                          await login();
                          showAlert == true
                              ? null
                              : progressIndicater(context, showLoading = true);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      width: 325,
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white54),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, signUpScreenRoute);
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot your password?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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

  login() async {
    try {
      await authService.signInWithEmailAndPassword(
          emailController.text.toString(), passwordController.text.toString());

      Navigator.pushNamedAndRemoveUntil(
          context, homepageScreenRoute, (route) => false);
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
      title: "ALERT",
      desc: e.toString(),
    ).show();
  }
}
