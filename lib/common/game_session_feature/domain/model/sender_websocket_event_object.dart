import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/feature/game_screen/domain/models/game_field.dart';

import 'package:json_annotation/json_annotation.dart';

// class WebsocketEvent
class SenderWebsocketEvent{
  final SenderWebsocketEventType eventType;

  SenderWebsocketEvent({required this.eventType});

}


class WebsocketGameSessionEventSession extends SenderWebsocketEvent{
  final GameSession gameSession;

  WebsocketGameSessionEventSession({required super.eventType, required this.gameSession});
}


enum SenderWebsocketEventType{
 UpdateSessionState

}