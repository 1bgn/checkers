import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/common/game_session_feature/domain/model/user_connection.dart';
import 'package:checker/feature/game_screen/domain/models/game_field.dart';

import 'package:json_annotation/json_annotation.dart';

// class WebsocketEvent
class SenderWebsocketEvent{
  final SenderWebsocketEventType eventType;

  SenderWebsocketEvent({required this.eventType});

}


class JoinWebsocketGameSessionEventSession extends SenderWebsocketEvent{
final UserConnection userConnection;

  JoinWebsocketGameSessionEventSession({required super.eventType, required this.userConnection});

}
class UpgradeWebsocketGameSessionEventSession extends SenderWebsocketEvent{
  final GameSession gameSession;

  UpgradeWebsocketGameSessionEventSession({required super.eventType, required this.gameSession});




}


enum SenderWebsocketEventType{
 UpdateSessionState,
  Join

}