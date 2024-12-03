import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_session_request.g.dart';

@JsonSerializable()
class GetSessionRequest{

  @JsonKey(name: "session_id")
  final String sessionId;
  factory GetSessionRequest.fromJson(Map<String, dynamic> json) =>
      _$GetSessionRequestFromJson(json);

  GetSessionRequest({ required this.sessionId});


  Map<String, dynamic> toJson()=>_$GetSessionRequestToJson(this);
}