import 'package:bitsgap/domain/auth.dart';
import 'package:bitsgap/presentation/auth/view_models/user_view_model.dart';
import 'package:bitsgap/presentation/extensions/validation_extension.dart';
import 'package:mobx/mobx.dart';

part 'auth_mobx.g.dart';

class AuthMobx = BaseAuthMobx with _$AuthMobx;

abstract class BaseAuthMobx with Store {
  BaseAuthMobx({
    required AuthRepository authRepository,
  }) : _repository = authRepository;

  final AuthRepository _repository;

  @observable
  bool isAuthenticating = false;
  @observable
  bool isLoggingOut = false;
  @observable
  bool isAuthenticated = false;
  @observable
  bool hasError = false;
  @observable
  bool usernameIsInvalid = false;
  @observable
  bool passwordIsInvalid = false;
  @observable
  bool emailIsInvalid = false;
  @observable
  String errorMessage = '';
  @observable
  UserViewModel userViewModel = UserViewModel.empty();

  @action
  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    _resetErrorState();

    final isInvalid = _checkValidation(username: username, password: password, email: email);
    if (isInvalid) return;

    _startAuthenticating();

    await Future.delayed(
      const Duration(milliseconds: 500),
      () => null,
    );

    final user = UserInfo(
      username: username,
      password: password,
      email: email,
    );

    final response = await _repository.register(user);

    if (response) {
      isAuthenticated = true;

      userViewModel = UserViewModel.fromEntity(user);
    } else {
      _throwError('The user with this email or username is already exist');
    }

    _stopAuthenticating();
  }

  @action
  Future<void> login({
    required String username,
    required String password,
  }) async {
    _startAuthenticating();

    await Future.delayed(
      const Duration(milliseconds: 500),
      () => null,
    );

    final user = UserInfo(
      username: username,
      password: password,
    );

    final response = await _repository.login(user);

    if (response != null) {
      isAuthenticated = true;

      userViewModel = UserViewModel.fromEntity(response);
    } else {
      _throwError('Wrong username or password');
    }

    _stopAuthenticating();
  }

  @action
  Future<void> checkUserAuthenticatedInApp() async {
    final response = await _repository.checkUserAuthenticatedInApp();

    if (response != null) {
      isAuthenticated = true;

      userViewModel = UserViewModel.fromEntity(response);
    }
  }

  @action
  Future<void> logout() async {
    isLoggingOut = true;

    final response = await _repository.logout();

    if (response) {
      isAuthenticated = false;

      userViewModel = UserViewModel.empty();
    } else {
      _throwError("could't logout, please try again");
    }

    isLoggingOut = false;
  }

  void _startAuthenticating() {
    isAuthenticating = true;
  }

  void _stopAuthenticating() {
    isAuthenticating = false;
  }

  void _throwError(String errorMessage) {
    this.errorMessage = errorMessage;
    hasError = true;
    Future.delayed(
      const Duration(seconds: 1),
      () {
        hasError = false;
        this.errorMessage = '';
      },
    );
  }

  bool _checkValidation({
    required String username,
    required String password,
    required String email,
  }) {
    var isInvalid = false;
    final passwordValidationError = password.validatePassword();
    final emailValidationError = email.validateEmail();

    if (passwordValidationError.isNotEmpty) {
      _throwError(passwordValidationError);
      passwordIsInvalid = true;
      isInvalid = true;
    }
    if (username.isEmpty) {
      _throwError('Please write your username');
      usernameIsInvalid = true;
      isInvalid = true;
    }
    if (emailValidationError.isNotEmpty) {
      _throwError(emailValidationError);
      emailIsInvalid = true;
      isInvalid = true;
    }

    return isInvalid;
  }

  void _resetErrorState() {
    usernameIsInvalid = false;
    emailIsInvalid = false;
    passwordIsInvalid = false;
  }
}
