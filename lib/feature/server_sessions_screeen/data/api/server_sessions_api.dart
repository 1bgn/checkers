
import 'package:checker/common/game_session_feature/data/dto/full_game_session_item_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../common/user_feature/data/dto/user_dto.dart';
import '../../../../core/config/config.dart';

part 'server_sessions_api.g.dart';
@LazySingleton()
@RestApi()
abstract class ServerSessionsApi{
  @factoryMethod
  factory ServerSessionsApi(Dio dio, {String? baseUrl}) = _ServerSessionsApi;
  @GET("/get_sessions")
  Future<List<FullGameSessionItemResponse>> getSessions(@Query("is_private") bool isPrivate);
}