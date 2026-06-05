import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/services/auth_services.dart';

final authProvider = ChangeNotifierProvider<AppAuthProvider>((ref) {
  return AppAuthProvider();
});

class AppAuthProvider extends ChangeNotifier {
  final AuthServices _authServices = AuthServices();

  bool _isLoading = false;

  User? _user;

  String? _errorMessage;

  AppAuthProvider() {
    _authServices.user.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;

  bool get isLoading => _isLoading;

  bool get isAuthenticated => user != null;

  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<bool> registerWithEmailAndPassword(String email,
      String password,) async {
    _setLoading(true);

    try {
      User? user = await _authServices.registerWithEmailAndPassword(
        email,
        password,
      );

      return user != null;
    } catch (e) {
      debugPrint('Register Error : $e');

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    try {
      _setLoading(true);

      await _authServices.signOut();
    } catch (e) {
      debugPrint("Sign Out Error : $e");
    } finally {
      _setLoading(false);
    }
  }



  Future<bool> sighWithEmailAndPassword(String email,
      String password,) async {
    _setLoading(true);

    try {
      User? user = await _authServices.sighWithEmailAndPassword(
        email,
        password,
      );

      return user != null;
    } catch (e) {
      debugPrint("Email Sign In Error : $e");



      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> forgotPassword(String email,) async {
    _setLoading(true);

    try {
      await _authServices.forgotPassword(
        email,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(
        "Forgot Password Error : ${e.message}",
      );

      _setError(
        e.message ?? "Reset password failed",
      );

      return false;
    } catch (e) {
      debugPrint(
        "Forgot Password Error : $e",
      );

      _setError(
        "Something went wrong",
      );

      return false;
    } finally {
      _setLoading(false);
    }
  }
}