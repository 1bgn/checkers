import 'dart:convert';

import 'package:checker/common/user_feature/data/api/user_api.dart';
import 'package:checker/core/constants/local_constants.dart';
import 'package:checker/core/exception/failure.dart';
import 'package:checker/feature/main_screen/data/api/main_api.dart';
import 'package:checker/feature/main_screen/data/dto/register_user_dto.dart';
import 'package:checker/feature/main_screen/data/repository/imain_repository.dart';
import 'package:checker/feature/main_screen/domain/model/register_user.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:localstorage/localstorage.dart';

import '../../../../common/user_feature/data/dto/user_dto.dart';
import '../../../../common/user_feature/domain/model/user.dart';

@LazySingleton(as: IMainRepository)
class MainRepository implements IMainRepository{
  final MainApi _mainApi;
  final UserApi _userApi;

  MainRepository(this._mainApi, this._userApi);
  @override
  Future<User> registerUser(RegisterUser registerUser) async {
    try{
      final result = await _mainApi.registerUser(mapRegisterUserTo(registerUser));

      return mapUserDtoTo(result);
    }on DioException catch (e){
      if(e.response?.statusCode==400){
        throw Failure(message: e.response!.data["message"]);
      }
      throw Failure(message: e.toString());
    }
  }
  RegisterUserDto mapRegisterUserTo(RegisterUser registerUser){
    return RegisterUserDto(nickname:registerUser.nickname);
  }
  User mapUserDtoTo(UserDto registerUser){
    return User(nickname: registerUser.nickname,accessToken: registerUser.accessToken);
  }
  UserDto mapUserDtoFrom(User registerUser){
    return UserDto(nickname: registerUser.nickname,accessToken: registerUser.accessToken, id: registerUser.id);
  }


  @override
  void saveUser(User mainUser) {
    localStorage.setItem(LocalConstants.localUser, json.encode(mapUserDtoFrom(mainUser)));
  }



}