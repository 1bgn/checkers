import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoodUniversalOverlay extends StatefulWidget {
  const GoodUniversalOverlay({super.key,required this.text});
  final String text;

  @override
  State<GoodUniversalOverlay> createState() =>
      _GoodUniversalOverlayState();
}

class _GoodUniversalOverlayState
    extends State<GoodUniversalOverlay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(bottom: 24, left: 24, right: 24,top: 24),
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 2.85),
                        blurRadius: 11.39,
                        spreadRadius: -0.71,
                        color: const Color(0xff14171A).withOpacity(0.11))
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.done,color: Colors.green,),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        widget.text,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
