import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BlackChecker extends StatelessWidget{
  final bool isSelected;
  final bool isQueen;

  const BlackChecker({super.key,  this.isSelected=false, required this.isQueen});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isSelected?Positioned.fill(child: Container(width: 20,height: 20,decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.green),)):SizedBox(),

        Positioned.fill(
          child: Container(
            margin: EdgeInsets.all(isSelected?3:0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              isQueen
                  ? "assets/images/black_cat_queen.svg"
                  : "assets/images/black_cat_checker.svg",

            ),
          ),
        ),
      ],
    );
  }

}