import 'package:checker/feature/game_screen/data/dto/emoji_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'game_screen_api.g.dart';
@LazySingleton()
@RestApi()
abstract class GameScreenApi{
  @factoryMethod
  factory GameScreenApi(Dio dio, {String? baseUrl}) = _GameScreenApi;
  @GET("/send-emoji")
  Future<void> sendEmoji(@Queries() EmojiDto emojiDto );
  @GET("/lose")
  Future<void> lose(@Query("session_id") String sessionId,@Query("nickname")String nickname);

}