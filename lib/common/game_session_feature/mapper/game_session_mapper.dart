import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/common/game_session_feature/mapper/game_field_mapper.dart';
import 'package:checker/common/game_session_feature/mapper/game_session_item_mapper.dart';
import 'package:checker/core/di/di_container.dart';
import 'package:injectable/injectable.dart';

import '../data/dto/full_game_session_response.dart';
@injectable
class GameSessionMapper{
  GameSession to(FullGameSessionDtoResponse r){
    final gameSessionMapper = getIt<GameFieldMapper>();
    final sessionItemMapper= getIt<GameSessionItemMapper>();
    return GameSession(id: r.id,gameField: gameSessionMapper.to(r.gameField),gameSessionItem: sessionItemMapper.to(r.gameSessionItem));
  }
  FullGameSessionDtoResponse from(GameSession r){
    final gameSessionMapper = getIt<GameFieldMapper>();
    final sessionItemMapper= getIt<GameSessionItemMapper>();
    return FullGameSessionDtoResponse(id: r.id,gameField: gameSessionMapper.from(r.gameField),gameSessionItem: sessionItemMapper.from(r.gameSessionItem));
  }

}