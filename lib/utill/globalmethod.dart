
import 'dart:async';

import 'package:edukit/model/address.dart';
import 'package:flutter/material.dart';

import 'color_resources.dart';
import 'dimensions.dart';

showPrint(String title, dynamic message){
  print("$title  =>=>   $message");
}

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;

  const DelayedAnimation({super.key, required this.child, required this.delay});

  @override
  State<DelayedAnimation> createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    final curve =
    CurvedAnimation(curve: Curves.decelerate, parent: _controller);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay != -1) {
      _controller.forward();
    } else {
      Timer(Duration(seconds: widget.delay), () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}

validateFields(String val, String hint, String error) {
  if (val.isEmpty) {
    return error;
  }else{
    if(hint == "Mobile"){
      if(!isValidMobile(val)){
        return "Enter Correct mobile Number";
      }
    }
    if(hint == "Email"){
      if(!isValidEmail(val)){
        return "Enter Correct Email Address";
      }
    }


    if(hint == "Password"){
      if(!isValidPassword(val)){
        return "Password must be 8+ characters, with uppercase, lowercase, special, and number.";
      }
    }
    if(hint == "PinCode"){
      if(val.length != 6){
        return "Enter Correct Pin Code";
      }
    }
  }
}

bool isValidEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isValidPassword(String password) {
  return RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
      .hasMatch(password);
}

bool isValidMobile(String mobile) {
  return RegExp(r'^[0-9]{10}$').hasMatch(mobile);
}
