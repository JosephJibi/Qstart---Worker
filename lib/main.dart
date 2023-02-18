import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qstart_worker/Screens/MainScreens/LoginScreen.dart';
import 'package:qstart_worker/Screens/MainScreens/QuestionScreen.dart';
import 'package:qstart_worker/Screens/MainScreens/SplashScreen.dart';
import 'package:qstart_worker/Screens/worker/WorkerNavScreen.dart';
import 'package:qstart_worker/utilities/Dimensions.dart';
import 'Screens/MainScreens/RegistrationScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  // print(Dimensions.screenHeight);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}

