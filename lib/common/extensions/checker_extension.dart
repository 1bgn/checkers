import 'package:checker/feature/game_screen/domain/models/game_cell.dart';

import '../../feature/game_screen/domain/models/checker.dart';

extension CheckerExtension on List<Checker>{
  List<GameCell> get gc_positions => map((e)=>e.position).toList();
}