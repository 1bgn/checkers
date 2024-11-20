import 'package:checker/core/exception/failure.dart';
import 'package:checker/feature/main_screen/data/api/main_api.dart';
import 'package:checker/feature/main_screen/data/dto/register_user_dto.dart';
import 'package:checker/feature/main_screen/data/dto/user_response.dart';
import 'package:checker/feature/main_screen/data/repository/imain_repository.dart';
import 'package:checker/feature/main_screen/domain/model/main_user.dart';
import 'package:checker/feature/main_screen/domain/model/register_user.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: IMainRepository)
class MainRepository implements IMainRepository{
  final MainApi _mainApi;

  MainRepository(this._mainApi);
  @override
  Future<MainUser> registerUser(RegisterUser registerUser) async {
    try{
      final response = await _mainApi.registerUser(mapRegisterUserTo(registerUser));
      return mapUserDtoTo(response);
    }catch (e){
      throw Failure(message: e.toString());
    }
  }
  RegisterUserDto mapRegisterUserTo(RegisterUser registerUser){
    return RegisterUserDto(nickname:registerUser.nickname);
  }
  MainUser mapUserDtoTo(UserResponse registerUser){
    return MainUser(nickname: registerUser.nickname,accessToken: registerUser.accessToken);
  }

}