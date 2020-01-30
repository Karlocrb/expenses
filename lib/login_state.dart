import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginState with ChangeNotifier{
  bool _loggedIn = true;

bool isLoggedIn() => _loggedIn;


  void login(){
    _loggedIn = true;
    notifyListeners();
  }
void logout(){
_loggedIn = false;
notifyListeners();

}

}