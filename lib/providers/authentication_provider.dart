import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  String _signUpUsername;
  String _signUpEmail;
  String _signUpPassword;
  String _logInEmail;
  String _logInPassword;

  get signUpUsername => _signUpUsername;
  get signUpEmail => _signUpEmail;
  get signUpPassword => _signUpPassword;
  get logInEmail => _logInEmail;
  get logInPassword => _logInPassword;

  void setSignUpUsername(String username) {
    _signUpUsername = username;
    notifyListeners();
  }

  void setSignUpEmail(String email) {
    _signUpEmail = email;
    notifyListeners();
  }

  void setSignUpPassword(String password) {
    _signUpPassword = password;
    notifyListeners();
  }

  void setSignInEmail(String email) {
    _logInEmail = email;
    notifyListeners();
  }

  void setSignInPassword(String password) {
    _logInPassword = password;
    notifyListeners();
  }
}
