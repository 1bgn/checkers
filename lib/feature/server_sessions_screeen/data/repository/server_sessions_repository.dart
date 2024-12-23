import 'package:checker/common/game_session_feature/data/api/game_session_api.dart';
import 'package:checker/common/game_session_feature/data/dto/get_session_request.dart';
import 'package:checker/common/game_session_feature/domain/model/get_session.dart';
import 'package:checker/common/game_session_feature/mapper/game_session_mapper.dart';
import 'package:checker/core/di/di_container.dart';
import 'package:checker/feature/server_sessions_screeen/data/api/server_sessions_api.dart';
import 'package:checker/feature/server_sessions_screeen/data/repository/iserver_sessions_repository.dart';
import 'package:checker/feature/server_sessions_screeen/domain/model/game_session_item.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/game_session_feature/domain/model/connect_to_game.dart';
import '../../../../common/game_session_feature/domain/model/game_connection.dart';
import '../../../../common/game_session_feature/domain/model/game_session.dart';
import '../../../../common/game_session_feature/mapper/connect_to_game_mapper.dart';
import '../../../../common/game_session_feature/mapper/game_session_item_mapper.dart';
@LazySingleton(as: IServerSessionsRepository)
 class ServerSessionsRepository implements IServerSessionsRepository{
   final ServerSessionsApi _serverSessionsApi;
   final GameSessionApi gameSessionApi;


  ServerSessionsRepository(this._serverSessionsApi, this.gameSessionApi);
  @override
  Future<List<GameSessionItem>> getSessions(bool isPrivate)async{
    final result = await _serverSessionsApi.getSessions(isPrivate);
    final mapper = getIt<GameSessionItemMapper>();
    return result.map((e)=>mapper.to(e)).toList();
  }
   @override
   Future<GameConnection> connectToGame(ConnectToGame connectToGame) async {
     final mapper = getIt<ConnectToGameMapper>();
     final response = await gameSessionApi.connectToGame(mapper.to(connectToGame));
     return mapper.from(response);

   }
   @override
   Future<GameSession> getSession(
       GetSession getSession) async {
     final response = await gameSessionApi.getSession(
         GetSessionRequest(sessionId: getSession.sessionId));
     final sessionMapper = getIt<GameSessionMapper>();

     return sessionMapper.to(response);
   }
}