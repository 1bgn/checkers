import 'package:checker/common/game_session_feature/domain/model/get_session.dart';
import 'package:checker/feature/server_sessions_screeen/domain/model/game_session_item.dart';

import '../../../../common/game_session_feature/domain/model/connect_to_game.dart';
import '../../../../common/game_session_feature/domain/model/game_connection.dart';
import '../../../../common/game_session_feature/domain/model/game_session.dart';

abstract class IServerSessionsRepository{
  Future<List<GameSessionItem>> getSessions(bool isPrivate);
  Future<GameConnection> connectToGame(ConnectToGame connectToGame);
  Future<GameSession> getSession(
      GetSession getSession) ;
}