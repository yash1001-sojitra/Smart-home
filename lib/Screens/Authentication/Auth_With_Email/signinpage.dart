// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarthome/Core/Constant/string.dart';
import 'package:smarthome/Core/Constant/textcontroller.dart';
import 'package:smarthome/Screens/User/Homepage/homepage.dart';

import '../../../Logic/Providers/internet_provider.dart';
import '../../../Logic/Providers/sign_in_provider.dart';
import '../../../Logic/Services/auth_services/auth_service.dart';
import '../../Splash/splashscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../User/other/snack_bar.dart';

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

  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController facebookController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController phoneController =
      RoundedLoadingButtonController();

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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Sign In",
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
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
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
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
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
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ForgotpassScreenRoute);
                              },
                              child: const Text(
                                "Forgot your password?",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ]),
                    ),
                    Container(
                      width: 325,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                          emailController.clear();
                          passwordController.clear();
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
                    const SizedBox(height: 30),
                    Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          " Or Connect Using ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            handleGoogleSignIn();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              "assets/images/google.png",
                              height: 35,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            "assets/images/facebook.png",
                            height: 35,
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, NumberauthScreenRoute);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              "assets/images/iphone.png",
                              height: 35,
                            ),
                          ),
                        ),
                      ],
                    )
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

  Future handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
      googleController.reset();
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          googleController.reset();
        } else {
          // checking whether user exists or not
          sp.checkUserExists().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.success();
                        Navigator.pushNamed(context, homepageScreenRoute);
                      })));
            } else {
              // user does not exist
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.success();
                        Navigator.pushNamed(context, homepageScreenRoute);
                      })));
            }
          });
        }
      });
    }
  }

  Future<void> signupwithfacebook(BuildContext context) async {}

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
