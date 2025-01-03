import 'dart:async';
import 'dart:ui';

import '../../../common/game_session_feature/domain/model/connect_to_game.dart';
import '../../../common/game_session_feature/domain/model/receive_websocket_event_object.dart';
import '../../../common/game_session_feature/domain/model/sender_websocket_event_object.dart';
import '../../../common/user_feature/domain/model/user.dart';
import '../../../core/enum/diag.dart';
import '../domain/models/checker.dart';
import '../domain/models/checker_position.dart';
import '../domain/models/game_cell.dart';

abstract class IGameScreenService {
  Future<StreamController<SenderWebsocketEvent>> listenGameSession(ConnectToGame connectionToGame, StreamController<ReceiveWebsocketEvent> connection);

  Color? isWin(
      List<Checker> deadBlackPositions, List<Checker> deadWhitePositions);

  CheckerPosition getPosition(GameCell checker, double cellWidth);

  Future<void> sendEmoji(String sessionId,String emoji,String accessTokenFrom);
  bool getSound();
  Future<void> lose(String sessionId,String nickname);



  GameCell? findTwiceEnemyDiagCells(List<GameCell> positions);
  User getCurrentUser();
  bool isNearByDiagCells(GameCell gameCell1, GameCell gameCell2);

  List<GameCell> getFreeCells({
    required List<GameCell> cells,
    required Checker checker,
    required List<Checker> blackPositions,
    required List<Checker> whitePositions,
  });

  List<GameCell> takeDiagCells(
      {required List<GameCell> cells,
      required GameCell startPoint,
      required Diag diag,
      int length = 8});

  List<GameCell> cellsBeforeSecondPos(
      List<GameCell> diag, GameCell secondPoint);

  Checker? getKilledCheckersAfterAttack({
    required List<GameCell> cells,
    required Checker checker,
    required GameCell firstPos,
    required GameCell secondPos,
    required List<Checker> blackPositions,
    required List<Checker> whitePositions,
  });

  Diag defineDiag(GameCell startPoint, GameCell endPoint);

  List<GameCell> getFreeCellsAfterAttack({
    required Checker checker,
    required List<GameCell> cells,
    required List<Checker> blackPositions,
    required List<Checker> whitePositions,
  });

  Map<Diag, List<GameCell>> groupByDiag(
      {required GameCell startPoint, required List<GameCell> cells});

  List<GameCell> sortPointsByDistantionPoint(
      {required GameCell gameCell, required List<GameCell> cells});

  double distanceBetweenPoints(GameCell point1, GameCell point2);

  GameCell cellAfterSecondPos(Diag diag, GameCell secondPos);
}
