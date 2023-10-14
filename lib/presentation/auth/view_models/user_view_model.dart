import 'package:bitsgap/domain/auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_view_model.freezed.dart';

@freezed
class UserViewModel with _$UserViewModel {
  const factory UserViewModel({
    required String usename,
    required String email,
  }) = _UserViewModel;

  const UserViewModel._();

  factory UserViewModel.fromEntity(UserInfo entity) {
    return UserViewModel(
      usename: entity.username,
      email: entity.email ?? '',
    );
  }

  factory UserViewModel.empty() {
    return const UserViewModel(
      usename: '',
      email: '',
    );
  }
}
