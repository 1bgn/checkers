import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentStage extends StatelessWidget{
  final Color color;
  final Color? winner;

  const CurrentStage({super.key, required this.color, this.winner});

  @override
  Widget build(BuildContext context) {
    if(winner==Colors.black){
      return Text(
        "Победили черные",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500),
      );
    }else if (winner==Colors.white){
        return Text(
          "Победили белые",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500),
        );
    }
    return Text(
      "Текущий ход: ${color== Colors.white ? "Белые" : "Черные"}",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500),
    );
  }

}