import 'dart:async';

import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/common/user_feature/domain/model/user.dart';
import 'package:checker/feature/game_screen/domain/models/emoji_model.dart';
import 'package:checker/feature/game_screen/domain/models/game_field.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/game_session_feature/domain/model/receive_websocket_event_object.dart';
import '../../../../../common/game_session_feature/domain/model/sender_websocket_event_object.dart';

part 'online_game_screen_state.freezed.dart';
@freezed
class OnlineGameScreenState with _$OnlineGameScreenState{
  const factory OnlineGameScreenState({
    @Default(false) final bool isLoading,
    @Default(false) final bool isUploaded,
    @Default(false) final bool isDeleted,
    @Default(false) final bool isReadonly,
    // @Default(false) final bool isYourStep,
    @Default(GameField()) final GameField gameField,
    @Default(null) final GameField? lastStepGameField,
    @Default([]) final List<GameField> history,

    @Default(GameSession()) final GameSession gameSession,
    @Default(null) final User? currentUser,
    @Default(null)final  Color?  colorCurrentUser,
    @Default(null) final User? opponentUser,
    @Default(0) int timeCounter,
    @Default(null) Color? winner,
    @Default(null)  StreamController<ReceiveWebsocketEvent>? reciever,
    @Default(null) StreamController<SenderWebsocketEvent>? sender,
    @Default(null) EmojiModel? currentEmoji,

  }) = _OnlineGameScreenState;


}