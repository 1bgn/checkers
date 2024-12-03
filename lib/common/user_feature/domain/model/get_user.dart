import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user.freezed.dart';
part 'get_user.g.dart';

@Freezed(toJson: true)
 class GetUser with _$GetUser{
  const factory GetUser({
    @Default("")  String nickname,
  })=_GetUser;


}