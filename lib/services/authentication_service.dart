import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService extends ChangeNotifier {
  AuthenticationService(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  String _username;
  String _email;
  String _password;

  get username => _username;
  get email => _email;
  get password => _password;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<String> logIn() async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: _email, password: _password);
      _username = _firebaseAuth.currentUser.displayName;
      return 'log_in_succuessful';
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<String> signUp() async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: _email, password: _password);

      final User firebaseUser = _firebaseAuth.currentUser;

      firebaseUser.updateProfile(displayName: _username);

      firebaseUser.reload();

      return 'sign_up_successful';
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<String> logOut() async {
    try {
      await _firebaseAuth.signOut();
      return 'log_out_successful';
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> resetPassword() async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: _email);
      return 'password_reset_email_sent';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
