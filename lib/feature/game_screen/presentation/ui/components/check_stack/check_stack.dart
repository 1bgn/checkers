import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckStack extends StatelessWidget{
  final String svgIcon;
  final int count;

  const CheckStack({super.key, required this.svgIcon, required this.count});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(height: 40,

            
            child: Center(
              child: Stack(children: List.generate(count, (index) => Padding(
                padding:  EdgeInsets.only(left: index*20.0),
                child: Container(decoration: BoxDecoration(color:Colors.white,shape: BoxShape.circle),child: SvgPicture.asset(svgIcon,width: 40,)),
              )),),
            ),
          ),
        ),
      ],
    );
  }

}