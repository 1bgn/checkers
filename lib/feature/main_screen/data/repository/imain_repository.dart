import 'package:checker/feature/main_screen/data/dto/user_dto.dart';
import 'package:checker/feature/main_screen/domain/model/register_user.dart';

import '../../domain/model/main_user.dart';

abstract class IMainRepository{
  Future<MainUser> registerUser(RegisterUser registerUser);
 MainUser? getUser();
 void saveUser(MainUser userResponse);
}