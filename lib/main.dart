import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_edir/View/Pages/EdirPage/edir_page.dart';
import 'package:on_edir/View/Pages/LoginSignUp/login_signin_page.dart';
import 'package:on_edir/View/Pages/MainPage/main_page.dart';
import 'package:on_edir/translation/translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyBowme8acOL5BbxxptiTTAV8uCq0-7tbfA",
        appId: "1:965611862391:web:e29d7851c15e7120988972",
        messagingSenderId: "965611862391",
        projectId: "onedir-42e14"));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  Widget checkUser(BuildContext context) {
    User auth = FirebaseAuth.instance.currentUser;
    if (auth != null) {
      return const MainPage();
    } else {
      return const LogInSignInPage();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Language(),
      debugShowCheckedModeBanner: false,
      title: 'On Edir'.tr,
      locale: const Locale('en', 'EN'),
      theme: ThemeData.dark(),
      home: checkUser(context),
    );
  }
}
