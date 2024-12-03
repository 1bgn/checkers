import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_connection.freezed.dart';
part 'user_connection.g.dart';

@Freezed(toJson: true,fromJson: true)
class UserConnection with _$UserConnection{
  const factory UserConnection({
  @Default("")  @JsonKey(name: "session_id")  String sessionId,
  })=_UserConnection;
  // factory UserConnection.fromJson(Map<String, dynamic> json) =>
  //     _$UserConnection(json);
}