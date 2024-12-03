import 'package:checker/common/game_session_feature/domain/model/receive_websocket_event_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'websocket_event_type_json.g.dart';
@JsonSerializable()
class WebsocketEventTypeJson{
  @JsonKey(name: "websocket_event_type")
  final ReceiveWebsocketEventType event;

  WebsocketEventTypeJson({required this.event,});


  factory WebsocketEventTypeJson.fromJson(Map<String, dynamic> json) =>
      _$WebsocketEventTypeJsonFromJson(json);

  Map<String, dynamic> toJson() => _$WebsocketEventTypeJsonToJson(this);
}