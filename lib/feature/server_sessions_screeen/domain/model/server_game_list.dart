import 'package:freezed_annotation/freezed_annotation.dart';

import 'game_session_item.dart';

part 'server_game_list.freezed.dart';

@freezed
class ServerGameList with _$ServerGameList{
  const factory ServerGameList({
    @Default("") String serverName,
    @Default([]) List<GameSessionItem> sessions,

})=_GameServerList;
}