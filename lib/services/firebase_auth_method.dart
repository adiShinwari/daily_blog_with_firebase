// ignore_for_file: unused_local_variable

import 'package:blog_application/utils/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethod {
  final FirebaseAuth _auth;
  FirebaseAuthMethod(
    this._auth,
  );

  Future<bool> signupWithEmailPass({
    required String email,
    required password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      return false;
    }
  }

  Future<bool> loginWithEmailPass(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      return false;
    }
  }

  Future<bool> googleSignin(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      return false;
    }
  }
}
