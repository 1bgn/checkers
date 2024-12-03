import 'package:checker/common/game_session_feature/domain/model/connect_to_game.dart';
import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:checker/common/user_feature/data/repository/iuser_repository.dart';
import 'package:checker/common/user_feature/domain/model/user.dart';
import 'package:checker/feature/create_new_game/application/icreate_new_game_service.dart';
import 'package:checker/feature/create_new_game/data/create_new_game_repository/icreate_new_game_repository.dart';
import 'package:checker/feature/create_new_game/domain/model/create_game_session.dart';
import 'package:checker/feature/server_sessions_screeen/domain/model/game_session_item.dart';
import 'package:injectable/injectable.dart';

import '../../../common/game_session_feature/domain/model/game_session.dart';

@LazySingleton(as: ICreateNewGameService)
class CreateNewGameService implements ICreateNewGameService{
  final ICreateNewGameRepository _iCreateNewGameRepository;
  final IUserRepository _iUserRepository;

  CreateNewGameService({required ICreateNewGameRepository iCreateNewGameRepository, required IUserRepository iUserRepository}) : _iCreateNewGameRepository = iCreateNewGameRepository, _iUserRepository = iUserRepository;
  @override
  Future<GameSession> createGameSession(CreateGameSession createGameSession) {
    return _iCreateNewGameRepository.createGameSession(createGameSession);
  }

  @override
  User currentUser() {
    return _iUserRepository.getLocalUser()!;
  }

  @override
  Future<GameConnection> connectToGame(ConnectToGame connectToGame) {
    return _iCreateNewGameRepository.connectToGame(connectToGame);
  }

}