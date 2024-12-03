import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_to_game_response.g.dart';

@JsonSerializable()
class ConnectToGameResponse{
  @JsonKey(name: "side_color")
  final String sideColor;

  factory ConnectToGameResponse.fromJson(Map<String, dynamic> json) =>
      _$ConnectToGameResponseFromJson(json);

  ConnectToGameResponse({required this.sideColor});



  Map<String, dynamic> toJson()=>_$ConnectToGameResponseToJson(this);
}