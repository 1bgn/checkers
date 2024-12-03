import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/feature/game_screen/presentation/controller/game_screen_controller.dart';
import 'package:checker/feature/game_screen/presentation/ui/game_field_screen.dart';
import 'package:checker/feature/game_screen/presentation/ui/online_game_field_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di_container.dart';

class GameScreen extends StatelessWidget {
  final GameSession? gameSession;
  final GameConnection? gameConnection;

  const GameScreen({super.key, this.gameSession, this.gameConnection});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,

        title: gameSession==null?Text("Одиночная игра",):Text("Онлайн игра",),
      ),
      body: Builder(
        builder: (context) {

          return SafeArea(
            child: gameSession==null?GameFieldScreen():OnlineGameFieldScreen(gameSession: gameSession!,gameConnection: gameConnection!,),
          );
        }
      ),
    );
  }
}
