import 'package:checker/common/user_feature/domain/model/get_user.dart';

import '../../../common/user_feature/domain/model/user.dart';
import '../domain/model/register_user.dart';

abstract class IMainService{
  Future<User> registerUser(RegisterUser registerUser);
  User? getLocalUser();
  Future<User> getRemoteUser(GetUser getUser);
  void saveUser(User userResponse);

}