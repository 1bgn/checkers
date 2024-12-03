import 'dart:async';
import 'dart:convert';

import 'package:checker/common/game_session_feature/data/data_source/iwebsocket_data_source.dart';
import 'package:checker/common/game_session_feature/domain/model/connect_to_game.dart';
import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/common/game_session_feature/domain/model/receive_websocket_event_object.dart';
import 'package:checker/common/game_session_feature/domain/model/sender_websocket_event_object.dart';
import 'package:checker/common/game_session_feature/mapper/connect_to_game_mapper.dart';
import 'package:checker/common/game_session_feature/mapper/game_field_mapper.dart';
import 'package:checker/common/game_session_feature/mapper/game_session_mapper.dart';
import 'package:checker/core/di/di_container.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../core/config/config.dart';
import '../dto/full_game_session_response.dart';
import '../dto/websocket_event_type_json.dart';
import '../dto/websocket_gamefield_event_json.dart';
@LazySingleton(as: IWebsocketDataSource)
class WebsocketDataSource implements IWebsocketDataSource{
  IO.Socket? socket;
  @override
  Future<StreamController<SenderWebsocketEvent>> onEvent(ConnectToGame connectionToGame, StreamController<ReceiveWebsocketEvent> eventsFrom,) async{
    socket = IO.io(getIt<String>(),
        OptionBuilder().setTransports(['websocket']).enableForceNew().build());
    socket?.onConnect((_) {
      print('socket connected');
    });
    final sender = StreamController<SenderWebsocketEvent>();
    sender.stream.listen((message){
      switch(message.eventType){


        case SenderWebsocketEventType.UpdateSessionState:
          final mapper = getIt<GameSessionMapper>();
          final data = message as UpgradeWebsocketGameSessionEventSession;
          socket?.emit("update-game-session-event",mapper.from(data.gameSession));
          break;

        case SenderWebsocketEventType.Join:
          final data = message as JoinWebsocketGameSessionEventSession;
          socket?.emit("join",jsonEncode(data.userConnection.toJson()));
          print("CWDEVEWV  ${data.userConnection.toJson()}");
          break;
      }
    });


    socket!.on(
      'game-session-event',
          (m) {
        final message = jsonDecode(m);

        final websocketEventSessionFileJson =
        WebsocketEventTypeJson.fromJson(message);

        switch (websocketEventSessionFileJson.event) {



          case ReceiveWebsocketEventType.SessionEvent:
            eventsFrom.add(WebsocketGameSessionEvent(gameSession:prepareSession(message["data"]) ,websocketEventType: websocketEventSessionFileJson.event));

        }
      },
    );
    socket?.onDisconnect((_) {
      // socket?.emit("unjoin",
      //     jsonEncode(userConnectionMapper.mapFrom(userConnection).toJson()));
      eventsFrom.close();
      print("socket disconnected");
    });

    eventsFrom.onCancel = () {
      // socket?.emit("unjoin",
      //     jsonEncode(userConnectionMapper.mapFrom(userConnection).toJson()));
      print("connection disconnected");
      socket?.dispose();
    };
    return sender;
  }
  GameSession prepareSession(dynamic message){
    final mapper = getIt<GameSessionMapper>();

    return mapper.to(FullGameSessionDtoResponse.fromJson(message));
  }


}