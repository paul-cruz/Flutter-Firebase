import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/controllers/app_user.dart';
import 'package:flutter_firebase_app/screens/loading.dart';
import 'package:flutter_firebase_app/services/authentication.dart';
import 'package:flutter_firebase_app/utilities/routes.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(AppUser());
    Authentication.initializeFirebase(context: context);
    return GetMaterialApp(
      title: 'Flutter Authentication',
      getPages: routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      initialRoute: LoadingScreen.routeName,
    );
  }
}
