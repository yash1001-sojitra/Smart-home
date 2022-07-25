// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthome/Core/Constant/string.dart';
import 'package:smarthome/Screens/Authentication/Auth_Main/authmain.dart';
import 'package:smarthome/Screens/Authentication/Auth_With_Number/auth_number.dart';
import 'package:smarthome/Screens/Authentication/Auth_With_Number/otp_verification.dart';
import 'package:smarthome/Screens/Authentication/Forgot_Password/forgotpass.dart';
import 'package:smarthome/Screens/User/Homepage/Add_user/add_user.dart';
import 'package:smarthome/Screens/User/Homepage/homepage.dart';

import '../Logic/helper/helper.dart';
import '../Screens/Authentication/Auth_With_Email/signinpage.dart';
import '../Screens/Authentication/Auth_With_Email/signuppage.dart';
import '../Screens/Splash/onboardingscreen.dart';
import '../Screens/Splash/splashscreen.dart';
import '../Screens/User/Drawer/DrawerScreens/profile.dart';

class Routes {
  late int initScreen;
  Future<void> checkForOnBordScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initScreen = prefs.getInt("initScreen")!;
  }

  static const _id = 'RouteGenerator';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    log(_id, msg: "Pushed ${settings.name}(${args ?? ''})");
    switch (settings.name) {

      //splash screens
      case splashScreenRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case onboardingScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());

      // authentication screens
      case authmainScreenRoute:
        return MaterialPageRoute(builder: (context) => const AuthMain());

      case singInScreenRoute:
        return MaterialPageRoute(builder: (context) => const SignInpage());

      case signUpScreenRoute:
        return MaterialPageRoute(builder: (context) => const SignupPage());

      case NumberauthScreenRoute:
        return MaterialPageRoute(builder: (context) => const NumberAuth());

      case ForgotpassScreenRoute:
        return MaterialPageRoute(builder: (context) => const ForgotPass());

      case MyProfilePageScreenRoute:
        return MaterialPageRoute(builder: (context) => const MyProfilePage());

      case AdduserProfileScreenRoute:
        return MaterialPageRoute(builder: (context) => const AdduserScreen());

      case otpverificationScreenRoute:
        return MaterialPageRoute(
            builder: (context) => VerifyPhoneNumberScreen(
                  phoneNumber: args,
                ));

      // main screens
      case homepageScreenRoute:
        return MaterialPageRoute(builder: (context) => const Homepage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
