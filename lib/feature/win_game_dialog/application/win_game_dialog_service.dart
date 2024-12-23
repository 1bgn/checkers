import 'dart:async';

import 'package:checker/feature/win_game_dialog/data/repository/win_game_session_dialog_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class WinGameDialogService {
  final WinGameSessionDialogRepository _repository;

  WinGameDialogService({required WinGameSessionDialogRepository repository}) : _repository = repository;

  Future<void> resetGameField(String sessionId)=>_repository.winGameDialogApi.resetGameField(sessionId);
  Future<void> finishGame(String sessionId)=>_repository.winGameDialogApi.finishGame(sessionId);

}