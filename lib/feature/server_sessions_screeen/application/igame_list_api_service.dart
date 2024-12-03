import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/common/game_session_feature/domain/model/get_session.dart';

import '../../../common/game_session_feature/domain/model/connect_to_game.dart';
import '../../../common/game_session_feature/domain/model/game_connection.dart';
import '../../../common/user_feature/domain/model/user.dart';
import '../domain/model/game_session_item.dart';

abstract class IGameListApiService{
  Future<List<GameSessionItem>> getSessions(bool isPrivate);

  User currentUser();
  Future<GameConnection> connectToGame(ConnectToGame connectToGame);
  Future<GameSession> getSession(GetSession getSession);

}