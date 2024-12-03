import 'dart:async';

import 'package:checker/common/game_session_feature/data/data_source/iwebsocket_data_source.dart';
import 'package:checker/common/game_session_feature/data/repository/igame_repository.dart';
import 'package:checker/common/game_session_feature/domain/model/connect_to_game.dart';
import 'package:checker/common/game_session_feature/domain/model/receive_websocket_event_object.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/sender_websocket_event_object.dart';
@LazySingleton(as: IGameRepository)
class GameRepository implements IGameRepository{
  final IWebsocketDataSource iWebsocketDataSource;

  GameRepository(this.iWebsocketDataSource);
  @override
  Future<StreamController<SenderWebsocketEvent>> onEvent(ConnectToGame connectionToGame, StreamController<ReceiveWebsocketEvent> connection) {
    return iWebsocketDataSource.onEvent(connectionToGame, connection);
  }

}