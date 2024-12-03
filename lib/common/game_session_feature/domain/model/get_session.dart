import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_session.freezed.dart';

@freezed
class GetSession with _$GetSession{
  const factory GetSession({

    @Default("") String sessionId,

  })=_GetSession;
}