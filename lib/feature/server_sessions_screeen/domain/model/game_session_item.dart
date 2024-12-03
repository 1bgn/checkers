import 'package:checker/common/user_feature/domain/model/user.dart';
import 'package:checker/feature/game_screen/domain/models/checker.dart';
import 'package:checker/feature/game_screen/domain/models/game_cell.dart';
import 'package:checker/feature/game_screen/domain/models/game_field.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_session_item.freezed.dart';

@freezed
class GameSessionItem with _$GameSessionItem{
  const factory GameSessionItem({
    // @Default(GameField()) GameField gameField,
    @Default(null)final User? whiteGamePlayer,
    @Default(null) final User? blackGamePlayer,
    @Default(User())final User creator,
    @Default(false) final bool isPrivate,
    @Default(false) final bool isFinished,
    @Default(null) final String? password,
    @Default("") final String sessionId,
    @Default("") final String id



})=_GameSessionItem;
}