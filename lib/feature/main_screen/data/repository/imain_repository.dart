import 'package:checker/common/user_feature/data/dto/get_user_dto.dart';
import 'package:checker/common/user_feature/domain/model/get_user.dart';
import 'package:checker/feature/main_screen/domain/model/register_user.dart';

import '../../../../common/user_feature/domain/model/user.dart';


abstract class IMainRepository{
  Future<User> registerUser(RegisterUser registerUser);
 void saveUser(User userResponse);
}