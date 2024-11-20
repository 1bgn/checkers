import 'package:checker/feature/game_screen/domain/models/checker.dart';
import 'package:checker/feature/game_screen/domain/models/game_cell.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_player.freezed.dart';

@freezed
class GamePlayer with _$GamePlayer{
  const factory GamePlayer({
    @Default(0) int id,
    @Default("") String nickname,
    @Default("") String token,



})=_GamePlayer;
}