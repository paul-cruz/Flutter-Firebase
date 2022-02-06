import 'package:flutter/material.dart';

class CustomSnackBar {
  static SnackBar customSnackBar({required alertContent}) {
    return SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        alertContent,
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 0.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
