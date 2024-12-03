import 'dart:async';

import '../../domain/model/connect_to_game.dart';
import '../../domain/model/receive_websocket_event_object.dart';
import '../../domain/model/sender_websocket_event_object.dart';

abstract class IGameRepository{
  Future<StreamController<SenderWebsocketEvent>> onEvent(ConnectToGame connectionToGame, StreamController<ReceiveWebsocketEvent> connection);
}