import 'package:checker/feature/game_screen/domain/models/checker.dart';
import 'package:checker/feature/game_screen/domain/models/game_cell.dart';
import 'package:checker/feature/game_screen/domain/models/game_field.dart';
import 'package:checker/feature/server_list_screeen/domain/model/game_player.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_session.freezed.dart';

@freezed
class GameSession with _$GameSession{
  const factory GameSession({
    // @Default(GameField()) GameField gameField,
    @Default(GamePlayer()) GamePlayer whiteGamePlayer,
    @Default(GamePlayer()) GamePlayer blackGamePlayer,
    @Default(false) bool isPrivate,
    @Default(false) bool isFinished,
  @Default(null) GamePlayer? winner,
    @Default(null) int? password,



})=_GameSession;
}