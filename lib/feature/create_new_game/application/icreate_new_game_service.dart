import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';

import '../../../common/game_session_feature/domain/model/connect_to_game.dart';
import '../../../common/game_session_feature/domain/model/game_session.dart';
import '../../../common/user_feature/domain/model/user.dart';
import '../domain/model/create_game_session.dart';

abstract class ICreateNewGameService{
  Future<GameSession> createGameSession(CreateGameSession createGameSession);
  User currentUser();
  Future<GameConnection> connectToGame(ConnectToGame connectToGame);

}