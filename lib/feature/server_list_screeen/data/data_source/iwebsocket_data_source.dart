import 'package:checker/feature/server_list_screeen/domain/model/server_game_list.dart';

abstract class IWebsocketDataSource{
  Future<void> onGameListListener(Function(ServerGameList serverGameList) onGameListReceived);

}