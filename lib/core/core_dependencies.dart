import 'package:bitsgap/core/core.dart';
import 'package:bitsgap/core/di/dependencies.dart';
import 'package:bitsgap/core/di/di.dart';

class CoreDependencies extends Dependencies {
  @override
  Future<void> register(DI di) async {
    di
      ..registerLazySingleton<CustomJsonDecoder>(() => CustomJsonDecoder([]))
      ..registerLazySingleton<JsonStringConverter>(() => JsonStringConverter(jsonDecoder: di()));
  }
}
