// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smarthome/Core/Constant/string.dart';
import '../../../Logic/Providers/userData_provider.dart';
import '../../../Logic/Services/auth_services/auth_service.dart';
import '../../../Logic/helper/helper.dart';
import '../../Splash/splashscreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class NumberAuth extends StatefulWidget {
  const NumberAuth({Key? key}) : super(key: key);

  @override
  State<NumberAuth> createState() => _NumberAuthState();
}

class _NumberAuthState extends State<NumberAuth> {
  late AuthService authService;
  bool showLoading = false;
  bool showAlert = false;
  bool ispasswordvisible = true;
  final _formkey = GlobalKey<FormState>();
  // TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController facebookController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController phoneController =
      RoundedLoadingButtonController();

  String? phoneNumber;

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
                        "Login",
                        style: GoogleFonts.cormorantGaramond(
                          textStyle: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "With Number",
                        style: GoogleFonts.cormorantGaramond(
                          textStyle: const TextStyle(
                              fontSize: 40,
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
                          onChanged: (((value) => '')),
                          obscureText: false,
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17),
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
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
                          ),
                        )),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18),
                      child: IntlPhoneField(
                        dropdownTextStyle: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        autofocus: true,
                        invalidNumberMessage: 'Invalid Phone Number!',
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (phone) =>
                            phoneNumber = phone.completeNumber,
                        initialCountryCode: 'IN',
                        flagsButtonPadding: const EdgeInsets.only(right: 10),
                        showDropdownIcon: false,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                          if (isNullOrBlank(phoneNumber) ||
                              !_formkey.currentState!.validate()) {
                            showSnackBar('Please enter a valid phone number!');
                          } else {
                            Navigator.pushNamed(
                              context,
                              otpverificationScreenRoute,
                              arguments: phoneNumber,
                            );
                          }
                        },
                        child: const Text(
                          "Verify",
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
                          onTap: () async {
                            UsereDataProvider().signInWithGoogle();
                            Navigator.pushNamed(context, homepageScreenRoute);
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
