import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/feature/game_screen/domain/models/game_field.dart';

import 'package:json_annotation/json_annotation.dart';

// class WebsocketEvent
class ReceiveWebsocketEvent{
  final ReceiveWebsocketEventType websocketEventType;

  ReceiveWebsocketEvent({required this.websocketEventType});

}

class WebsocketUserConnection extends ReceiveWebsocketEvent{
  WebsocketUserConnection({required this.userConnection,required super.websocketEventType});
  final GameConnection userConnection;
}
class WebsocketGameSessionEvent extends ReceiveWebsocketEvent{
  final GameSession gameSession;

  WebsocketGameSessionEvent({required super.websocketEventType, required this.gameSession});
}


enum ReceiveWebsocketEventType{
  SessionEvent,


}
