import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  static const routeName = "/loading";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff6587bb),
            Color(0xff5a87a8),
            Color(0xff507d95),
            Color(0xff466387),
          ],
        ),
      ),
      child: const Center(
          child: Text(
        "Loading...",
        style: TextStyle(color: Colors.white, decoration: TextDecoration.none),
      )),
    );
  }
}
