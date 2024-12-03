import 'package:checker/common/game_session_feature/data/dto/game_field_response.dart';
import 'package:checker/feature/game_screen/domain/models/game_field.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/model/receive_websocket_event_object.dart';

part 'websocket_gamefield_event_json.g.dart';
@JsonSerializable()
class WebsocketGameFieldEvent{
  @JsonKey(name: "websocket_event_type")
  final ReceiveWebsocketEventType event;
  @JsonKey(name: "game_field")
  final GameFieldResponse gameField;



  factory WebsocketGameFieldEvent.fromJson(Map<String, dynamic> json) =>
      _$WebsocketGameFieldEventFromJson(json);

  WebsocketGameFieldEvent({required this.event, required this.gameField});

  Map<String, dynamic> toJson() => _$WebsocketGameFieldEventToJson(this);
}