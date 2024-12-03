import 'package:checker/common/user_feature/domain/model/get_user.dart';
import 'package:checker/feature/main_screen/domain/model/register_user.dart';

import '../../../../common/user_feature/domain/model/user.dart';


abstract class IUserRepository{
 Future<User> getUser(GetUser getUser);
 User? getLocalUser();

}