// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthome/Logic/Services/fireStoreServices/user_firestore_services.dart';

import 'Logic/Providers/userData_provider.dart';
import 'Logic/Services/auth_services/auth_service.dart';
import 'Routes/routes.dart';

Future<void> main() async {
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
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
