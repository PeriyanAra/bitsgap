# bitsgap

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

To run project you have to install flutter first. How to install flutter you can read here.
[Flutter Installation Guide](https://flutter.dev/docs/get-started/install)


### Install fvm

FVM helps with the need for consistent app builds by referencing the Flutter SDK version used on a per-project basis. It also allows you to have multiple Flutter versions installed to quickly validate and test upcoming Flutter releases with your apps without waiting for Flutter installation every time.

```bash
dart pub global activate fvm
```

Install flutter version, which is defined for project.

```bash
fvm install
```

### Android configuration

If you use Android Studio, you can define flutter sdk with following steps.

[Configure Android Studio](https://fvm.app/docs/getting_started/configuration#android-studio)


### Usage 

To use fvm with flutter you need to add `fvm` before flutter command. Here are some examples.

```bash
fvm install
fvm flutter test
fvm flutter pub get
fvm flutter analyze
fvm flutter run
```

### 1. Generate all data containing files with Freezed(view models, models, entities, DTOs)
For example:

## 1. View Models
```dart
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
```

## 2. Entity
``` dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info.freezed.dart';

@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    required String username,
    required String password,
    String? email,
  }) = _UserInfo;

  const UserInfo._();
}
```

## 3. DTO
```dart
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
```

### 2. Create corresponding folders in the modules (Domain, Presentation, Data) with a name that describes your feature:
For example auth:
```
 Presentation: auth
 Domain: auth
 Data: auth
```

Start from `Domain` implementation. Create entities (models) that will describe the structure of response of the `Data` layer:
``` dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info.freezed.dart';

@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    required String username,
    required String password,
    String? email,
  }) = _UserInfo;

  const UserInfo._();
}
```

Create repository abstraction implementation will be provided in the `Data` layer:
``` dart
import 'package:bitsgap/domain/auth/entities.dart';

abstract class AuthRepository {
  Future<bool> register(UserInfo user);

  Future<UserInfo?> login(UserInfo user);

  Future<UserInfo?> checkUserAuthenticatedInApp();

  Future<bool> logout();
}
```

The next step is `Data` layer implementation.
Implement `DTO` objects (other words response models):
```dart
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
```

The method toEntity() works as a mapper, it converts `DTO` objects to the entities described in the `Domain` layer.

Implement `DataSources`, it will be used in repository implementation.
```dart
import 'package:bitsgap/data/auth/dto/user_info_dto.dart';
import 'package:bitsgap/data/constants.dart';
import 'package:bitsgap/data/database/database_constants.dart';
import 'package:bitsgap/domain/auth/entities/user_info.dart';
import 'package:bitsgap/domain/domain.dart';
import 'package:sqflite/sqflite.dart';

class AuthLocalDataSource {
  AuthLocalDataSource({
    required AppKeyValueStorage appKeyValueStorage,
    required Database database,
  })  : _database = database,
        _storage = appKeyValueStorage;

  final Database _database;
  final AppKeyValueStorage _storage;

  Future<bool> register(UserInfo user) async {
    try {
      final token = DateTime.now().toString();

      await _database.rawInsert(
        '''
      INSERT INTO ${DatabaseConstants.users}(
        ${DatabaseConstants.username},
        ${DatabaseConstants.email},
        ${Constants.accessToken},
        ${DatabaseConstants.password}
        ) VALUES(?, ?, ?, ?)''',
        [
          user.username,
          user.email?.toString(),
          token,
          user.password,
        ],
      );

      await _storage.write<String>(Constants.accessToken, token);

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<UserInfoDto?> login(UserInfo user) async {
    final result = await _database.query(
      DatabaseConstants.users,
      where: '${DatabaseConstants.username} = ? AND ${DatabaseConstants.password} = ?',
      whereArgs: [user.username, user.password],
    );

    if (result.isNotEmpty) {
      await _storage.write<String>(
        Constants.accessToken,
        result.first[Constants.accessToken]! as String,
      );

      return UserInfoDto.fromJson(result.first);
    }

    return null;
  }

  Future<bool> logout() async {
    try {
      await _storage.remove(Constants.accessToken);

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<UserInfoDto?> checkUserAuthenticatedInApp() async {
    try {
      final token = await _storage.read<String>(Constants.accessToken);

      if (token != null) {
        final result = await _database.query(
          DatabaseConstants.users,
          where: '${Constants.accessToken} = ?',
          whereArgs: [token],
        );

        if (result.isNotEmpty) {
          return UserInfoDto.fromJson(result.first);
        }
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
```

Add repository implementation:
```dart
import 'package:bitsgap/data/auth.dart';
import 'package:bitsgap/domain/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthLocalDataSource authLocalDataSource,
  }) : _localDataSource = authLocalDataSource;

  final AuthLocalDataSource _localDataSource;

  @override
  Future<UserInfo?> login(UserInfo user) async {
    final userInfoDto = await _localDataSource.login(user);

    if (userInfoDto != null) {
      return userInfoDto.toEntity();
    }

    return null;
  }

  @override
  Future<bool> register(UserInfo user) {
    return _localDataSource.register(user);
  }

  @override
  Future<UserInfo?> checkUserAuthenticatedInApp() async {
    final userInfoDto = await _localDataSource.checkUserAuthenticatedInApp();

    return userInfoDto?.toEntity();
  }

  @override
  Future<bool> logout() {
    return _localDataSource.logout();
  }
}
```

Don't forget to register your Services, Data sources and Repository implementations in `DataDependencies`

```dart
import 'package:bitsgap/core/di/dependencies.dart';
import 'package:bitsgap/core/di/di.dart';
import 'package:bitsgap/data/auth.dart';
import 'package:bitsgap/data/auth/auth_repositoy_impl.dart';
import 'package:bitsgap/data/database/database_creator.dart';
import 'package:bitsgap/domain/auth.dart';
import 'package:sqflite/sqflite.dart';

class DataDependencies extends Dependencies {
  @override
  Future<void> register(DI di) async {
    di
      ..registerSingleton<Database>(
        await DatabaseCreator.initDatabase(),
      )
      ..registerFactory(
        () => AuthLocalDataSource(
          database: di(),
          appKeyValueStorage: di(),
        ),
      )
      ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(
          authLocalDataSource: di(),
        ),
      );
  }
}
```

When all described above steps are done, we can start with the `Presentation` layer.
Add Mobx implementation and execute `Repository` from the `Domain` layer:

```dart
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
```

### 3. Register and provide Mobx
When you created the Mobx, it needs to registration in `PresentationDependencies`

```dart
import 'package:bitsgap/core/di/dependencies.dart';
import 'package:bitsgap/core/di/di.dart';
import 'package:bitsgap/presentation/auth.dart';

class PresentationDependencies extends Dependencies {
  @override
  Future<void> register(DI di) async {
    final authMobx = AuthMobx(
      authRepository: di(),
    );

    di.registerLazySingleton(
      () => authMobx,
    );

    await authMobx.checkUserAuthenticatedInApp();
  }
}
```

To provide the Mobx, use `Provider`:
```dart
Provider(
    create: (_) => di<AuthMobx>(),
    child
);
```

### 4. Routing and navigation
For navigation we use `AutoRouter`.

First of all give your screen class this annotation [app_router.dart]:
```dart
@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  ...
}
```

After this run this script `fvm flutter pub run build_runner build --delete-conflicting-outputs`, and add your screen in [app_router.dart] file:
```dart
import 'package:auto_route/auto_route.dart';
import 'package:bitsgap/presentation/auth/auth_animated_screen.dart';
import 'package:bitsgap/presentation/auth/auth_screen.dart';
import 'package:bitsgap/presentation/profile/profile_screen.dart';
import 'package:bitsgap/router/authenticated_screen.dart';
import 'package:bitsgap/router/authentication_screen.dart';
import 'package:bitsgap/router/route_paths.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: RoutePaths.authentication,
          page: AuthenticationRoute.page,
          children: [
            AutoRoute(
              initial: true,
              path: RoutePaths.auth,
              page: AuthRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: RoutePaths.authentiacted,
          page: AuthenticatedRoute.page,
          children: [
            AutoRoute(
              initial: true,
              path: RoutePaths.profile,
              page: ProfileRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: RoutePaths.authAnimated,
          page: AuthAnimatedRoute.page,
        ),
      ];
}
```

For navigation to some route use:
```dart
AutoRouter.of(context).push(HomeRoute());
```
or:
```dart
context.router.push(HomeRoute());
```

## Built With
* [flutter](https://flutter.dev) - Design beautiful apps


## Contributing
Please read [Dart Code Style](https://dart.dev/guides/language/effective-dart/style) for details on our code of conduct, and the process for submitting pull requests to us.


## Authors
* **Ara Periyan** - *Flutter Freelancer* 
# bitsgap
