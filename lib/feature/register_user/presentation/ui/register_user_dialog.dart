import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterUserDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Dialog(child: Column(mainAxisSize: MainAxisSize.min,children: [
      Text("Кажется, вы заходите первый раз"),

    ],),);
  }

}