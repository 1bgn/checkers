import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/feature/game_screen/presentation/ui/game_field_screen.dart';
import 'package:checker/feature/game_screen/presentation/ui/online_game_field_screen.dart';
import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

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

        title: gameSession == null
            ? Text(
                "Одиночная игра",
              )
            : Text(
                "Онлайн игра: ${gameSession!.gameSessionItem.id.substring(0,8)}",
              ),
      ),
      body: Builder(builder: (context) {
        return SafeArea(
          child: LayoutBuilder(builder: (context, size) {
            return WrapperScene(
              sizeCanvas: Size(size.maxWidth, size.maxHeight),
              colors: [],
              children: [
                gameSession == null
                    ? GameFieldScreen()
                    : OnlineGameFieldScreen(
                        gameSession: gameSession!,
                        gameConnection: gameConnection!,
                      ),
                SnowWidget(
                  snowConfig: SnowConfig(
                    count: 10,
                    size: 20,
                    color: Color(0xb3ffffff),
                    areaXStart: 0,
                    areaYStart: 0,
                    areaXEnd: size.maxWidth,
                    waveMinSec: 5,
                    waveMaxSec: 20,
                  ),
                ),
              ],
            );
          }),
        );
      }),
    );
  }
}
