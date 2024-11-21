import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BadUniversalOverlay extends StatefulWidget {
  const BadUniversalOverlay({super.key,required this.text});
  final String text;

  @override
  State<BadUniversalOverlay> createState() =>
      _BadUniversalOverlayState();
}

class _BadUniversalOverlayState
    extends State<BadUniversalOverlay> {
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
                    SvgPicture.asset("assets/images/close_round.svg"),
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
