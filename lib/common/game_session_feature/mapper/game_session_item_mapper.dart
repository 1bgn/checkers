import 'package:checker/common/game_session_feature/data/dto/full_game_session_item_response.dart';
import 'package:injectable/injectable.dart';

import '../../../feature/server_sessions_screeen/domain/model/game_session_item.dart';
import '../../user_feature/data/dto/user_dto.dart';
import '../../user_feature/domain/model/user.dart';
import '../data/dto/full_game_session_response.dart';
@injectable
class GameSessionItemMapper{
  GameSessionItem to(FullGameSessionItemResponse r) {
    final w = r.whiteGamer;
    final b = r.blackGamer;
    return GameSessionItem(isPrivate: r.isPrivate,
        sessionId: r.sessionId,
        isFinished: r.isFinished,
        password: r.password,
        id: r.id,
        creator: User(id: r.creator.id,nickname: r.creator.nickname,accessToken: r.creator.accessToken),
        blackGamePlayer: b != null ? User(
            accessToken: b.accessToken, nickname: b.nickname, id: b.id) : null,
        whiteGamePlayer: w != null ? User(
            accessToken: w.accessToken, nickname: w.nickname, id: w.id) : null);
  }
  FullGameSessionItemResponse from(GameSessionItem  r) {
    final w = r.whiteGamePlayer;
    final b = r.blackGamePlayer;
    return FullGameSessionItemResponse(isPrivate: r.isPrivate,
        sessionId: r.sessionId,
        isFinished: r.isFinished,
        password: r.password,
        creator: UserDto(id: r.creator.id,nickname: r.creator.nickname,accessToken: r.creator.accessToken),
        blackGamer: b != null ? UserDto(
            accessToken: b.accessToken, nickname: b.nickname, id: b.id) : null,
        whiteGamer: w != null ? UserDto(
            accessToken: w.accessToken, nickname: w.nickname, id: w.id) : null,
        id: r.id);
  }
}