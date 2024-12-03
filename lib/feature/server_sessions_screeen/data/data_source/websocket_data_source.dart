// import 'dart:convert';
//
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// import 'package:checker/feature/server_list_screeen/data/data_source/iwebsocket_data_source.dart';
// import 'package:checker/feature/server_list_screeen/domain/model/server_game_list.dart';
// import 'package:socket_io_client/socket_io_client.dart';
//
// import '../../../../core/config/config.dart';
//
// class WebsocketDataSource implements IWebsocketDataSource{
//   @override
//   Future<void> onGameListListener(Function(ServerSessionsList serverGameList) onGameListReceived)async {
//     IO.Socket socket = IO.io('http://${Config.mainAddress}',
//         OptionBuilder().setTransports(['websocket']).enableForceNew().build());
//    socket.on("event", (m){
//      final message = jsonDecode(m);
//      print("MESSAGE");
//    });
//   }
//
// }