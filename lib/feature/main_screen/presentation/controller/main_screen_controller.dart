import 'package:checker/feature/main_screen/application/imain_service.dart';
import 'package:checker/feature/main_screen/domain/model/main_user.dart';
import 'package:checker/feature/main_screen/domain/model/register_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/main_screen_state.dart';


class MainScreenController extends Cubit<MainScreenState>{
  final IMainService _iMainService;
  MainScreenController(this._iMainService):super(const MainScreenState());

  void setPageIndex(int value){
    emit(state.copyWith(pageIndex: value));
  }
  Future<MainUser> registerMainUser(RegisterUser registerUser)async {
    final user = await _iMainService.registerUser(registerUser);
    emit(state.copyWith(currentUser: user));
    return user;
  }
}