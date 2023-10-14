// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthMobx on BaseAuthMobx, Store {
  late final _$isAuthenticatingAtom =
      Atom(name: 'BaseAuthMobx.isAuthenticating', context: context);

  @override
  bool get isAuthenticating {
    _$isAuthenticatingAtom.reportRead();
    return super.isAuthenticating;
  }

  @override
  set isAuthenticating(bool value) {
    _$isAuthenticatingAtom.reportWrite(value, super.isAuthenticating, () {
      super.isAuthenticating = value;
    });
  }

  late final _$isLoggingOutAtom =
      Atom(name: 'BaseAuthMobx.isLoggingOut', context: context);

  @override
  bool get isLoggingOut {
    _$isLoggingOutAtom.reportRead();
    return super.isLoggingOut;
  }

  @override
  set isLoggingOut(bool value) {
    _$isLoggingOutAtom.reportWrite(value, super.isLoggingOut, () {
      super.isLoggingOut = value;
    });
  }

  late final _$isAuthenticatedAtom =
      Atom(name: 'BaseAuthMobx.isAuthenticated', context: context);

  @override
  bool get isAuthenticated {
    _$isAuthenticatedAtom.reportRead();
    return super.isAuthenticated;
  }

  @override
  set isAuthenticated(bool value) {
    _$isAuthenticatedAtom.reportWrite(value, super.isAuthenticated, () {
      super.isAuthenticated = value;
    });
  }

  late final _$hasErrorAtom =
      Atom(name: 'BaseAuthMobx.hasError', context: context);

  @override
  bool get hasError {
    _$hasErrorAtom.reportRead();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.reportWrite(value, super.hasError, () {
      super.hasError = value;
    });
  }

  late final _$usernameIsInvalidAtom =
      Atom(name: 'BaseAuthMobx.usernameIsInvalid', context: context);

  @override
  bool get usernameIsInvalid {
    _$usernameIsInvalidAtom.reportRead();
    return super.usernameIsInvalid;
  }

  @override
  set usernameIsInvalid(bool value) {
    _$usernameIsInvalidAtom.reportWrite(value, super.usernameIsInvalid, () {
      super.usernameIsInvalid = value;
    });
  }

  late final _$passwordIsInvalidAtom =
      Atom(name: 'BaseAuthMobx.passwordIsInvalid', context: context);

  @override
  bool get passwordIsInvalid {
    _$passwordIsInvalidAtom.reportRead();
    return super.passwordIsInvalid;
  }

  @override
  set passwordIsInvalid(bool value) {
    _$passwordIsInvalidAtom.reportWrite(value, super.passwordIsInvalid, () {
      super.passwordIsInvalid = value;
    });
  }

  late final _$emailIsInvalidAtom =
      Atom(name: 'BaseAuthMobx.emailIsInvalid', context: context);

  @override
  bool get emailIsInvalid {
    _$emailIsInvalidAtom.reportRead();
    return super.emailIsInvalid;
  }

  @override
  set emailIsInvalid(bool value) {
    _$emailIsInvalidAtom.reportWrite(value, super.emailIsInvalid, () {
      super.emailIsInvalid = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'BaseAuthMobx.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$userViewModelAtom =
      Atom(name: 'BaseAuthMobx.userViewModel', context: context);

  @override
  UserViewModel get userViewModel {
    _$userViewModelAtom.reportRead();
    return super.userViewModel;
  }

  @override
  set userViewModel(UserViewModel value) {
    _$userViewModelAtom.reportWrite(value, super.userViewModel, () {
      super.userViewModel = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('BaseAuthMobx.register', context: context);

  @override
  Future<void> register(
      {required String email,
      required String username,
      required String password}) {
    return _$registerAsyncAction.run(() =>
        super.register(email: email, username: username, password: password));
  }

  late final _$loginAsyncAction =
      AsyncAction('BaseAuthMobx.login', context: context);

  @override
  Future<void> login({required String username, required String password}) {
    return _$loginAsyncAction
        .run(() => super.login(username: username, password: password));
  }

  late final _$checkUserAuthenticatedInAppAsyncAction =
      AsyncAction('BaseAuthMobx.checkUserAuthenticatedInApp', context: context);

  @override
  Future<void> checkUserAuthenticatedInApp() {
    return _$checkUserAuthenticatedInAppAsyncAction
        .run(() => super.checkUserAuthenticatedInApp());
  }

  late final _$logoutAsyncAction =
      AsyncAction('BaseAuthMobx.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
isAuthenticating: ${isAuthenticating},
isLoggingOut: ${isLoggingOut},
isAuthenticated: ${isAuthenticated},
hasError: ${hasError},
usernameIsInvalid: ${usernameIsInvalid},
passwordIsInvalid: ${passwordIsInvalid},
emailIsInvalid: ${emailIsInvalid},
errorMessage: ${errorMessage},
userViewModel: ${userViewModel}
    ''';
  }
}
