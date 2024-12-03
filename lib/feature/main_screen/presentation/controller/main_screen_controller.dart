import 'package:checker/common/user_feature/domain/model/get_user.dart';
import 'package:checker/feature/main_screen/application/imain_service.dart';
import 'package:checker/feature/main_screen/domain/model/register_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/user_feature/domain/model/user.dart';
import '../state/main_screen_state.dart';


class MainScreenController extends Cubit<MainScreenState>{
  final IMainService _iMainService;
  MainScreenController(this._iMainService):super(const MainScreenState());

  void setPageIndex(int value){
    emit(state.copyWith(pageIndex: value));
  }
  Future<User> registerMainUser(RegisterUser registerUser)async {
    final user = await _iMainService.registerUser(registerUser);
    emit(state.copyWith(currentUser: user));
    return user;
  }
  Future<User?> getRemoteUser(GetUser getUser)async {
    try{
      final user = await _iMainService.getRemoteUser(getUser);
      emit(state.copyWith(currentUser: user));
      return user;
    }catch(e){
      return null;
    }
  }
  void saveLocalUser(User mainUser){
    _iMainService.saveUser(mainUser);
    emit(state.copyWith(currentUser: mainUser));

  }
  User? getLocalUser(){
    return _iMainService.getLocalUser();
  }
}