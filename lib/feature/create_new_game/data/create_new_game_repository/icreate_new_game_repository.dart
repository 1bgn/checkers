import 'package:checker/common/game_session_feature/domain/model/connect_to_game.dart';
import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:checker/feature/create_new_game/domain/model/create_game_session.dart';

import '../../../../common/game_session_feature/domain/model/game_session.dart';


abstract class ICreateNewGameRepository{
  Future<GameSession> createGameSession(CreateGameSession createGameSession);
  Future<GameConnection> connectToGame(ConnectToGame connectToGame);
}