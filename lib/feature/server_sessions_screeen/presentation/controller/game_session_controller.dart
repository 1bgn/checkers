import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/common/game_session_feature/domain/model/get_session.dart';
import 'package:checker/feature/server_sessions_screeen/application/igame_list_api_service.dart';
import 'package:checker/feature/server_sessions_screeen/domain/model/game_session_item.dart';
import 'package:checker/feature/server_sessions_screeen/presentation/state/game_sessions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/game_session_feature/domain/model/connect_to_game.dart';
import '../../../../common/game_session_feature/domain/model/game_connection.dart';


class GameSessionController extends Cubit<GameSessionsState>{
  final IGameListApiService _gameListApiService;
  GameSessionController(this._gameListApiService):super(const GameSessionsState());

  Future<void> initGameSessions(bool isPrivate)async {
    final result = await _gameListApiService.getSessions(isPrivate);
    emit(state.copyWith(sessions: result));
  }
  Future<GameConnection> connectToGame(GameSessionItem item)async{
    final user = _gameListApiService.currentUser();
    final connection =  _gameListApiService.connectToGame(ConnectToGame(nickname:user.nickname,sessionId: item.sessionId ));
    return connection;
  }
  Future<GameSession> getSession(GetSession getSession){
    return _gameListApiService.getSession(getSession);
  }


}