import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_connection.freezed.dart';

@freezed
class GameConnection with _$GameConnection{
  const factory GameConnection({
    @Default(Colors.white) Color sideColor,

  })=_GameConnection;
}