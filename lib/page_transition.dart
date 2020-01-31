import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';


class AddPageTransition extends PageRouteBuilder{

final Widget page;

AddPageTransition(this.page)
 : super(
   transitionDuration: Duration(microseconds: 1),
  pageBuilder: (context, animamation1, animation2) => page,
  transitionsBuilder: (context, animation1, animation, child) => child);

  @override
  bool get opaque => false;
}