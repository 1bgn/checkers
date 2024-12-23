import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/feature/game_screen/domain/models/emoji_model.dart';

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
class FinishWebsocketGameSessionEvent extends ReceiveWebsocketEvent{

  FinishWebsocketGameSessionEvent({required super.websocketEventType,});
}

class EmojiWebsocketEvent extends ReceiveWebsocketEvent{
final EmojiModel emoji;

  EmojiWebsocketEvent( {required super.websocketEventType,required this.emoji});
}

enum ReceiveWebsocketEventType{
  SessionEvent,
  FinishGame,
  ResetGameField,
  EmojiEvent


}
