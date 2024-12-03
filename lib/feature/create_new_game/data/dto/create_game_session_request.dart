import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_game_session_request.g.dart';

@JsonSerializable()
class CreateGameSessionRequest{
  @JsonKey(name: "creator_nickname")
  final String creatorNickname;
  @JsonKey(name: "is_private")
  final bool isPrivate;
  final String password;
  factory CreateGameSessionRequest.fromJson(Map<String, dynamic> json) =>
  _$CreateGameSessionRequestFromJson(json);

  CreateGameSessionRequest({required this.creatorNickname, required this.isPrivate, required this.password});

  Map<String, dynamic> toJson() {
    return _$CreateGameSessionRequestToJson(this);
  }
}