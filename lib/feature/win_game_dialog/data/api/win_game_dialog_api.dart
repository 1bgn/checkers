
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'win_game_dialog_api.g.dart';
@Injectable()
@RestApi()
abstract class WinGameDialogApi{
  @factoryMethod
  factory WinGameDialogApi(Dio dio, {String? baseUrl}) = _WinGameDialogApi;
  @GET("/reset_game_field")
  Future<void> resetGameField(@Query("session_id") String sessionId);

  @POST("/finish_game")
  Future<void> finishGame(@Query("session_id") String sessionId);
}