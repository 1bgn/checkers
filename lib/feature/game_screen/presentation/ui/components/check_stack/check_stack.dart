import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckStack extends StatelessWidget {
  final String svgIcon;
  final int count;

  const CheckStack({super.key, required this.svgIcon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 30,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.brown,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 24,),
                  count!=0?Text("$count",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),):SizedBox(),
                  Stack(
                    children: List.generate(
                        count,
                        (index) => Padding(
                              padding: EdgeInsets.only(left: index * 20.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.brown.shade200, shape: BoxShape.circle),
                                  child: SvgPicture.asset(
                                    svgIcon,
                                    width: 40,
                                  )),
                            )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
