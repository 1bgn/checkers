
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../dto/user_dto.dart';

part 'user_api.g.dart';
@LazySingleton()
@RestApi()
abstract class UserApi{
  @factoryMethod
  factory UserApi(Dio dio, {String? baseUrl}) = _UserApi;
  @GET("/user")
  Future<UserDto> getRemoteUser(@Query("nickname") String nickname);

}