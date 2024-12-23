import 'dart:async';

import '../../../../common/game_session_feature/domain/model/connect_to_game.dart';
import '../../domain/model/receive_websocket_event_object.dart';
import '../../domain/model/sender_websocket_event_object.dart';

abstract class IWebsocketDataSource{
  Future<StreamController<SenderWebsocketEvent>> onEvent(ConnectToGame connectionToGame,StreamController<ReceiveWebsocketEvent> connection);

}