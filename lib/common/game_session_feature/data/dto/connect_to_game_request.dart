import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_to_game_request.g.dart';

@JsonSerializable()
class ConnectToGameRequest{
  @JsonKey(name: "nickname")
  final String nickname;
  @JsonKey(name: "session_id")
  final String sessionId;
  factory ConnectToGameRequest.fromJson(Map<String, dynamic> json) =>
      _$ConnectToGameRequestFromJson(json);

  ConnectToGameRequest({required this.nickname, required this.sessionId});


  Map<String, dynamic> toJson()=>_$ConnectToGameRequestToJson(this);
}