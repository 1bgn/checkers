import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Image.asset("assets/images/win.jpeg"),
      )),
    );
  }
}
