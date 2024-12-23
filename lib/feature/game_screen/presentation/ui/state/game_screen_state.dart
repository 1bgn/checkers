import 'package:checker/feature/game_screen/domain/models/game_field.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_screen_state.freezed.dart';
@freezed
class GameScreenState with _$GameScreenState{
  const factory GameScreenState({
    @Default(false) final bool isLoading,
    @Default(false) final bool isUploaded,
    @Default(false) final bool isDeleted,
    @Default(false) final bool isReadonly,
    @Default(GameField()) final GameField gameField,
    @Default(0) int timeCounter,
    @Default(null) Color? winner


  }) = _GameScreenState;


}