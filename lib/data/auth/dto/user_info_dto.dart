import 'package:bitsgap/domain/auth/entities/user_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_dto.freezed.dart';
part 'user_info_dto.g.dart';

@freezed
class UserInfoDto with _$UserInfoDto {
  const factory UserInfoDto({
    String? email,
    String? username,
    String? password,
  }) = _UserInfoDto;

  const UserInfoDto._();

  factory UserInfoDto.fromJson(Map<String, Object?> json) => _$UserInfoDtoFromJson(json);

  UserInfo toEntity() {
    return UserInfo(
      username: username ?? '',
      password: password ?? '',
      email: email,
    );
  }
}
