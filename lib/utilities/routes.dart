import 'package:flutter_firebase_app/screens/home.dart';
import 'package:flutter_firebase_app/screens/loading.dart';
import 'package:flutter_firebase_app/screens/login.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: Home.routeName, page: () => Home()),
  GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
  GetPage(name: LoadingScreen.routeName, page: () => LoadingScreen()),
];
