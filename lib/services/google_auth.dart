import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/custom_snack_bar.dart';

class GoogleAuthentication {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        await FirebaseAuth.instance.signOut();
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.customSnackBar(
                  alertContent:
                      'Error, la cuenta ya existe con credenciales diferentes'));
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar.customSnackBar(
                  alertContent:
                      'Error, las credenciales no coinciden, intenta de nuevo.'));
        }
      } catch (e) {
        await FirebaseAuth.instance.signOut();
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.customSnackBar(
            alertContent:
                'Error al usar inicio de sesión con Google, intenta de nuevo'));
      }
    }

    return user;
  }
}
