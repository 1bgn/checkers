import 'dart:convert';

import 'package:checker/common/user_feature/data/api/user_api.dart';
import 'package:checker/common/user_feature/data/dto/get_user_dto.dart';
import 'package:checker/common/user_feature/domain/model/get_user.dart';
import 'package:checker/core/constants/local_constants.dart';
import 'package:checker/core/exception/failure.dart';
import 'package:checker/feature/main_screen/data/api/main_api.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:localstorage/localstorage.dart';

import '../../../../common/user_feature/domain/model/user.dart';
import '../dto/user_dto.dart';
import 'iuser_repository.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository{
  final UserApi _userApi;

  UserRepository(this._userApi);


  User mapUserDtoTo(UserDto userDto){
    return User(nickname: userDto.nickname,accessToken: userDto.accessToken);
  }

  UserDto mapUserDtoFrom(User user){
    return UserDto(nickname: user.nickname,accessToken: user.accessToken, id: user.id);
  }
  @override
  Future<User> getUser(GetUser getUser)async {
   try {
     final res =await  _userApi.getRemoteUser(getUser.nickname);
     return User.fromJson(res.toJson());
   } on DioException catch (e) {
     if(e.response?.statusCode==404){
       throw Failure(message: e.response!.data["message"]);
     }

     throw Failure(message: e.toString());
   }catch(e){
     print("VDSVDSWDWE $e");
     rethrow;
   }

  }
  @override
  User? getLocalUser() {
    final res =  localStorage.getItem(LocalConstants.localUser);
    if(res !=null){
      return mapUserDtoTo(UserDto.fromJson(json.decode(res)));
    }
    return null;
  }


}