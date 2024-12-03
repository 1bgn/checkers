import 'package:checker/feature/game_screen/domain/models/checker.dart';
import 'package:checker/feature/game_screen/domain/models/game_cell.dart';
import 'package:flutter/material.dart';
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