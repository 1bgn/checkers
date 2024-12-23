import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/common/game_session_feature/domain/model/user_connection.dart';

// class WebsocketEvent
class SenderWebsocketEvent{
  final SenderWebsocketEventType eventType;

  SenderWebsocketEvent({required this.eventType});

}


class SessionEvent extends SenderWebsocketEvent{
final UserConnection userConnection;

  SessionEvent({required super.eventType, required this.userConnection});

}
class UpgradeWebsocketGameSessionEventSession extends SenderWebsocketEvent{
  final GameSession gameSession;

  UpgradeWebsocketGameSessionEventSession({required super.eventType, required this.gameSession});




}


enum SenderWebsocketEventType{
 UpdateSessionState,
  Join,

}