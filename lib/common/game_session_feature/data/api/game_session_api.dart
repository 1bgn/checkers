import 'package:checker/common/game_session_feature/data/dto/get_session_request.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../dto/connect_to_game_request.dart';
import '../dto/connect_to_game_response.dart';
import '../dto/full_game_session_response.dart';

part 'game_session_api.g.dart';
@injectable
@RestApi()
abstract class GameSessionApi{
  @factoryMethod
  factory GameSessionApi(Dio dio, {String? baseUrl}) = _GameSessionApi;

  @POST("/connect_to_game")
  Future<ConnectToGameResponse> connectToGame(@Body() ConnectToGameRequest connectToGameRequest);
  @GET("/get_session")
  Future<FullGameSessionDtoResponse> getSession(@Queries() GetSessionRequest createGameSessionDto);
}