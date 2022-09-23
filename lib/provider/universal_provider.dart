import 'package:flutter/material.dart';

class UniversalProvider with ChangeNotifier {
  bool _signupIsLoading = false;
  bool _loginIsLoading = false;
  bool _googleSignin = false;

  bool get googleSignin {
    return _googleSignin;
  }

  void toggleGoogleSignin() {
    _googleSignin = !googleSignin;
    notifyListeners();
  }

  bool get loginIsLoading {
    return _loginIsLoading;
  }

  bool get signupIsLoading {
    return _signupIsLoading;
  }

  void toggleLoginIsLoading() {
    _loginIsLoading = !_loginIsLoading;

    notifyListeners();
  }

  void toggleSignupIsLoading() {
    _signupIsLoading = !_signupIsLoading;
    notifyListeners();
  }
}
