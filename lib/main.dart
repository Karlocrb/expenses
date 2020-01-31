import 'package:expenses/page_transition.dart';
import 'package:expenses/pages/add_pages.dart';
import 'package:expenses/pages/home_page.dart';
import 'package:expenses/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      onGenerateRoute: (settings){
       Rect buttonRect = settings.arguments;

        if (settings.name == '/add'){
          return AddPageTransition(
            AddPage(
               buttonRect: buttonRect,
             ),
          );
        }
      },
      routes: {
        '/': (BuildContext context) {
          if (_loggedIn) {
            return HomePage();
          } else {
           return  LoginPage(
             onLoginSuccess: (){
               setState(() {
                 _loggedIn = true;
               });
             },
           );
          }
        },
        //'/add': (BuildContext context) => AddPage(),
      },
    );
  }
}
