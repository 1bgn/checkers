import 'package:checker/common/game_session_feature/data/dto/connect_to_game_request.dart';
import 'package:checker/common/game_session_feature/data/dto/connect_to_game_response.dart';
import 'package:checker/common/game_session_feature/domain/model/connect_to_game.dart';
import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConnectToGameMapper {
  ConnectToGameRequest to(ConnectToGame gameCell) {
    return ConnectToGameRequest(nickname: gameCell.nickname, sessionId: gameCell.sessionId);
  }
  GameConnection from(ConnectToGameResponse response) {
    return GameConnection(sideColor: response.sideColor=="white"?Colors.white:Colors.black);
  }
}
