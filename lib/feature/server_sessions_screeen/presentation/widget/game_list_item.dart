import 'package:checker/feature/server_sessions_screeen/domain/model/game_session_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameListItem extends StatelessWidget {
  final GameSessionItem item;
  const GameListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 24),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "${item.creator.nickname}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          ),
          Spacer(),
          Icon(Icons.arrow_circle_right_outlined)
        ],
      ),
    );
  }
}
