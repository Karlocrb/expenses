import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final Function onLoginSuccess;

  const LoginPage({Key key, this.onLoginSuccess}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Sign In'),
          onPressed: (){
            onLoginSuccess();
          },
        ),
      ),
      
    );
  }
}