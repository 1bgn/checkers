import '../domain/model/main_user.dart';
import '../domain/model/register_user.dart';

abstract class IMainService{
  Future<MainUser> registerUser(RegisterUser registerUser);

}