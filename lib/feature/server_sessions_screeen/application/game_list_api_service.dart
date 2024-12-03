import 'package:checker/common/game_session_feature/data/repository/igame_repository.dart';
import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/common/game_session_feature/domain/model/get_session.dart';
import 'package:checker/common/user_feature/data/repository/iuser_repository.dart';
import 'package:checker/feature/game_screen/application/igame_screen_service.dart';
import 'package:checker/feature/server_sessions_screeen/application/igame_list_api_service.dart';
import 'package:checker/feature/server_sessions_screeen/data/repository/iserver_sessions_repository.dart';
import 'package:checker/feature/server_sessions_screeen/domain/model/game_session_item.dart';
import 'package:injectable/injectable.dart';

import '../../../common/game_session_feature/domain/model/connect_to_game.dart';
import '../../../common/game_session_feature/domain/model/game_connection.dart';
import '../../../common/user_feature/domain/model/user.dart';
@LazySingleton(as: IGameListApiService)
class GameListApiService implements IGameListApiService{
  final IServerSessionsRepository _iServerSessionsRepository;
  final IUserRepository _iUserRepository;
  final IGameRepository _iGameRepository;

  GameListApiService(this._iServerSessionsRepository, this._iUserRepository, this._iGameRepository);
  @override
  Future<List<GameSessionItem>> getSessions(bool isPrivate) {
    return _iServerSessionsRepository.getSessions(isPrivate);
  }
  @override
  User currentUser() {
    return _iUserRepository.getLocalUser()!;
  }
  @override
  Future<GameConnection> connectToGame(ConnectToGame connectToGame) {
    return _iServerSessionsRepository.connectToGame(connectToGame);
  }

  @override
  Future<GameSession> getSession(GetSession getSession) {
   return _iServerSessionsRepository.getSession(getSession);
  }



}