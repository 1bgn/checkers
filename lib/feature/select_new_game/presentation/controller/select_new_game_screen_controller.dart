import 'package:checker/feature/select_new_game/application/select_new_game_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../state/select_new_game_screen_state.dart';
@injectable
class SelectNewGameScreenController extends Cubit<SelectNewGameScreenState> {
  final SelectNewGameService _selectNewGameService;
  SelectNewGameScreenController(this._selectNewGameService)
      : super(const SelectNewGameScreenState());
  Future<void> init()async{
    emit(state.copyWith(enableSound: _selectNewGameService.getSound()));
  }
  void setSound(bool enableSound){
    _selectNewGameService.setSound(enableSound);
    emit(state.copyWith(enableSound:enableSound));

  }
}