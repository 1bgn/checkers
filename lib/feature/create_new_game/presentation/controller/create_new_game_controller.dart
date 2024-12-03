import 'package:checker/common/game_session_feature/domain/model/connect_to_game.dart';
import 'package:checker/common/game_session_feature/domain/model/game_connection.dart';
import 'package:checker/common/game_session_feature/domain/model/game_session.dart';
import 'package:checker/common/user_feature/domain/model/get_user.dart';
import 'package:checker/feature/create_new_game/application/icreate_new_game_service.dart';
import 'package:checker/feature/create_new_game/domain/model/create_game_session.dart';
import 'package:checker/feature/main_screen/application/imain_service.dart';
import 'package:checker/feature/main_screen/domain/model/register_user.dart';
import 'package:checker/feature/server_sessions_screeen/presentation/state/game_sessions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/user_feature/domain/model/user.dart';
import '../ui/state/create_new_game_state.dart';
@LazySingleton()
class CreateNewGameController extends Cubit<CreateNewGameState> {
  final ICreateNewGameService _createNewGameService;

  CreateNewGameController(this._createNewGameService)
      : super(const CreateNewGameState());

  Future<GameSession> createNewGame() async {
    final user = _createNewGameService.currentUser();
    final result = await _createNewGameService.createGameSession(
        CreateGameSession(
            password: state.password,
            createNickName: user.nickname,
            isPrivate: state.isPrivate));

    emit(state.copyWith(session: result));
    return result;
  }
  Future<GameConnection> connectToGame()async{
    final user = _createNewGameService.currentUser();
    final connection =  _createNewGameService.connectToGame(ConnectToGame(nickname:user.nickname,sessionId: state.session.id ));
return connection;
  }
  void setPrivate(bool private){
    emit(state.copyWith(isPrivate: private));
  }
  void setPassword(String password){
    emit(state.copyWith(password: password));
  }
}
