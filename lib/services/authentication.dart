import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/home.dart';
import 'package:flutter_firebase_app/screens/login.dart';
import 'package:get/get.dart';

import '../controllers/app_user.dart';
import '../widgets/custom_snack_bar.dart';

class Authentication {
  static final appUser = Get.find<AppUser>();

  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      appUser.email.value = user.email!;
      appUser.name.value = user.displayName!;
      appUser.photoUrl.value = user.photoURL!;
      appUser.uid.value = user.uid;
      Get.offAndToNamed(Home.routeName);
    } else {
      Get.offAndToNamed(LoginScreen.routeName);
    }

    return firebaseApp;
  }

  static String isLoggedAlready(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    print(user);
    if (user != null) {
      return user.email!;
    }
    return "";
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAndToNamed(LoginScreen.routeName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.customSnackBar(
          alertContent: 'Error al iniciar sesión, intenta de nuevo'));
    }
  }
}
