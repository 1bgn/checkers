import 'dart:convert';

import 'package:checker/core/constants/local_constants.dart';
import 'package:checker/core/exception/failure.dart';
import 'package:checker/feature/main_screen/data/api/main_api.dart';
import 'package:checker/feature/main_screen/data/dto/register_user_dto.dart';
import 'package:checker/feature/main_screen/data/dto/user_dto.dart';
import 'package:checker/feature/main_screen/data/repository/imain_repository.dart';
import 'package:checker/feature/main_screen/domain/model/main_user.dart';
import 'package:checker/feature/main_screen/domain/model/register_user.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:localstorage/localstorage.dart';
@LazySingleton(as: IMainRepository)
class MainRepository implements IMainRepository{
  final MainApi _mainApi;

  MainRepository(this._mainApi);
  @override
  Future<MainUser> registerUser(RegisterUser registerUser) async {
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
  MainUser mapUserDtoTo(UserDto registerUser){
    return MainUser(nickname: registerUser.nickname,accessToken: registerUser.accessToken);
  }
  UserDto mapUserDtoFrom(MainUser registerUser){
    return UserDto(nickname: registerUser.nickname,accessToken: registerUser.accessToken);
  }
  @override
  MainUser? getUser() {
   final res =  localStorage.getItem(LocalConstants.localUser);
   if(res !=null){
     return mapUserDtoTo(UserDto.fromJson(json.decode(res)));
   }
   return null;
  }

  @override
  void saveUser(MainUser mainUser) {
    localStorage.setItem(LocalConstants.localUser, json.encode(mapUserDtoFrom(mainUser)));
  }

}