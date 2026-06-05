import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Future<User?> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Register Error : ${e.message}');
    } catch (e) {
      debugPrint('Register Error : $e');
    }

    return null;
  }



  Future<User?> sighWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Login Error : ${e.message}');
    } catch (e) {
      debugPrint('Email Login Error : $e');
    }

    return null;
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();

      await _auth.signOut();
    } catch (e) {
      debugPrint("Sign Out Error : $e");
    }
  }

  Future<void> forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
