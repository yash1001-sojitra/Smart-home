// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthome/Logic/Services/fireStoreServices/user_firestore_services.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'Logic/Providers/internet_provider.dart';
import 'Logic/Providers/userData_provider.dart';
import 'Logic/Services/auth_services/auth_service.dart';
import 'Logic/helper/globals.dart';
import 'Routes/routes.dart';

Future<void> main() async {
  Paint.enableDithering = true;
  int? initScreen;
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      StreamProvider.value(
        value: UserDataFirestoreService().getUserData(),
        initialData: null,
      ),
      ChangeNotifierProvider.value(
        value: UsereDataProvider(),
      ),
      Provider<AuthService>(
        create: (_) => AuthService(),
      ),
      Provider<UserDataFirestoreService>(
        create: (_) => UserDataFirestoreService(),
      ),
      // Provider<FirebasePhoneAuthProvider>(
      //   create: (_) => UserDataFirestoreService(),
      // ),
  
      ChangeNotifierProvider(
        create: ((context) => InternetProvider()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: MaterialApp(
        scaffoldMessengerKey: Globals.scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}



//colors

// light blue  #339DFA
// grey #978989

// grey #f5f5f6