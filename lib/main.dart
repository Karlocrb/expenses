
import 'package:expenses/pages/add_pages.dart';
import 'package:expenses/pages/home_page.dart';
import 'package:flutter/material.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/'    : (BuildContext context) => HomePage(),
        '/add' : (BuildContext context) => AddPage(),

      },
    );
  }
}
