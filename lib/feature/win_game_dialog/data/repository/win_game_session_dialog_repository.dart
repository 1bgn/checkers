import 'package:checker/feature/win_game_dialog/data/api/win_game_dialog_api.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class WinGameSessionDialogRepository{
final WinGameDialogApi winGameDialogApi;

  WinGameSessionDialogRepository({required this.winGameDialogApi});

  Future<void> resetGameField(String sessionId){
    return winGameDialogApi.resetGameField(sessionId);
  }
Future<void> finishGame(String sessionId){
  return winGameDialogApi.finishGame(sessionId);
}
}