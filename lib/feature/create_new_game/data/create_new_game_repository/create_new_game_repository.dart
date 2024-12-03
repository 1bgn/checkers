import 'package:checker/common/game_session_feature/data/api/game_session_api.dart';
import 'package:checker/common/game_session_feature/data/dto/full_game_session_response.dart';
import 'package:checker/common/game_session_feature/domain/model/connect_to_game.dart';
import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:checker/common/game_session_feature/mapper/connect_to_game_mapper.dart';
import 'package:checker/common/game_session_feature/mapper/game_session_item_mapper.dart';
import 'package:checker/common/user_feature/domain/model/user.dart';
import 'package:checker/core/di/di_container.dart';
import 'package:checker/feature/create_new_game/data/api/create_game_session_api.dart';
import 'package:checker/feature/create_new_game/data/create_new_game_repository/icreate_new_game_repository.dart';
import 'package:checker/feature/create_new_game/data/dto/create_game_session_request.dart';
import 'package:checker/feature/create_new_game/domain/model/create_game_session.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/game_session_feature/domain/model/game_session.dart';
import '../../../../common/game_session_feature/mapper/game_session_mapper.dart';
import '../../../server_sessions_screeen/domain/model/game_session_item.dart';

@LazySingleton(as: ICreateNewGameRepository)
class CreateNewGameRepository implements ICreateNewGameRepository {
  final CreateGameSessionApi createGameSessionApi;
  final GameSessionApi gameSessionApi;

  CreateNewGameRepository({required this.createGameSessionApi, required this.gameSessionApi});


  @override
  Future<GameSession> createGameSession(
      CreateGameSession createGameSession) async {
    final response = await createGameSessionApi.createGameSession(
        CreateGameSessionRequest(creatorNickname: createGameSession.createNickName,
            isPrivate: createGameSession.isPrivate,
            password: createGameSession.password));
    final sessionMapper = getIt<GameSessionMapper>();

    return sessionMapper.to(response);
  }

  @override
  Future<GameConnection> connectToGame(ConnectToGame connectToGame) async {
    final mapper = getIt<ConnectToGameMapper>();
    final response = await gameSessionApi.connectToGame(mapper.to(connectToGame));
    return mapper.from(response);

  }

}