import 'dart:async';

import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/feature/win_game_dialog/application/win_game_dialog_service.dart';
import 'package:checker/feature/win_game_dialog/presentation/state/win_game_dialog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WinGameDialogController extends Cubit<WinGameDialogState>{
  final WinGameDialogService winGameDialogService;
  WinGameDialogController(this.winGameDialogService):super(const WinGameDialogState());
  void init(GameSession gameSession){
    emit(state.copyWith(gameSession: gameSession));
  }
  Future<void> resetGame() async {
   await winGameDialogService.resetGameField(state.gameSession.id);
  }
  Future<void> finishGame() async {
    await winGameDialogService.finishGame(state.gameSession.id);
  }



}