import 'package:checker/feature/server_list_screeen/presentation/widget/game_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameListScreen extends StatelessWidget{
  final bool isPrivate;

  const GameListScreen({super.key, required this.isPrivate});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        children: [
          Expanded(
            child: ListView(children: [
              SizedBox(height: 12,),

              GameListItem(),
              GameListItem(),
              GameListItem(),
              GameListItem(),
              GameListItem(),
              GameListItem(),
              GameListItem(),
              GameListItem(),
              GameListItem(),
              GameListItem(),
              GameListItem(),
            ],),
          ),
        ],
      ),
    );
  }
}