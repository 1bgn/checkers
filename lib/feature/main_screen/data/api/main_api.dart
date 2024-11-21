
import 'package:checker/feature/main_screen/data/dto/user_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../dto/register_user_dto.dart';

part 'main_api.g.dart';
@LazySingleton()
@RestApi(baseUrl: "http://192.168.0.3/",)
abstract class MainApi{
  @factoryMethod
  factory MainApi(Dio dio, {String? baseUrl}) = _MainApi;
  @POST("/register_user")
  Future<UserDto> registerUser(@Body() RegisterUserDto registerUserDto);
}