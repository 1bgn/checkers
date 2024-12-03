
import 'package:checker/common/game_session_feature/data/dto/connect_to_game_response.dart';
import 'package:checker/common/game_session_feature/data/dto/full_game_session_response.dart';
import 'package:checker/common/game_session_feature/data/dto/connect_to_game_request.dart';
import 'package:checker/feature/create_new_game/data/dto/create_game_session_request.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../common/user_feature/data/dto/user_dto.dart';
import '../../../../core/config/config.dart';

part 'create_game_session_api.g.dart';
@LazySingleton()
@RestApi()
abstract class CreateGameSessionApi{
  @factoryMethod
  factory CreateGameSessionApi(Dio dio, {String? baseUrl}) = _CreateGameSessionApi;
  @POST("/create_game_session")
  Future<FullGameSessionDtoResponse> createGameSession(@Body() CreateGameSessionRequest createGameSessionDto);

}