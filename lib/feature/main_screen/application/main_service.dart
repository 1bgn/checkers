import 'package:checker/common/game_session_feature/data/repository/game_repository.dart';
import 'package:checker/common/game_session_feature/data/repository/igame_repository.dart';
import 'package:checker/common/game_session_feature/domain/model/connect_to_game.dart';
import 'package:checker/common/user_feature/data/repository/iuser_repository.dart';
import 'package:checker/common/user_feature/domain/model/get_user.dart';
import 'package:checker/feature/main_screen/application/imain_service.dart';
import 'package:checker/feature/main_screen/data/repository/imain_repository.dart';
import 'package:checker/feature/main_screen/domain/model/register_user.dart';
import 'package:injectable/injectable.dart';

import '../../../common/user_feature/domain/model/user.dart';

@LazySingleton(as: IMainService)
class MainService implements IMainService{
  final IMainRepository _iMainRepository;
  final IUserRepository _iUserRepository;
  final IGameRepository _iGameRepository;

  MainService(this._iMainRepository, this._iUserRepository, this._iGameRepository);
  @override
  Future<User> registerUser(RegisterUser registerUser) {
    return _iMainRepository.registerUser(registerUser);
  }

  @override
  User? getLocalUser() {
    return _iUserRepository.getLocalUser();

  }

  @override
  void saveUser(User userResponse) {
   return _iMainRepository.saveUser(userResponse);
  }

  @override
  Future<User> getRemoteUser(GetUser gu) {
    return _iUserRepository.getUser(gu);
  }



}