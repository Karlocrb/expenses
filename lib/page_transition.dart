import 'package:flutter/material.dart';


class AddPageTransition extends PageRouteBuilder{

final Widget page;

AddPageTransition(this.page) : super(
  pageBuilder: (context, animamatio1, animation) => page,
  transitionsBuilder: (context, animation1, animation, child) => page );


}