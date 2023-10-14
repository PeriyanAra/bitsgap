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
