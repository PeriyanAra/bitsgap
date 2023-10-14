import 'package:bitsgap/core/di/di.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart' hide FactoryFunc, FactoryFuncParam, DisposingFunc;

class DiGetItImplementation implements DI {
  DiGetItImplementation() : getIt = GetIt.asNewInstance();

  @visibleForTesting
  final GetIt getIt;

  // final Map<Type, InstanceProvider<Object>> _overrides = {};

  @override
  T get<T extends Object>({String? instanceName}) => getIt.get(instanceName: instanceName);

  @override
  T getWithParam<T extends Object, P>(
    P param, {
    String? instanceName,
  }) =>
      getIt.get(instanceName: instanceName, param1: param);

  @override
  void registerFactory<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) {
    getIt.registerFactory(() => _getOverride<T>() ?? factoryFunc(), instanceName: instanceName);
  }

  @override
  void registerFactoryParam<T extends Object, P1>(
    FactoryFuncParam<T, P1> factoryFuncParam, {
    String? instanceName,
  }) {
    getIt.registerFactoryParam<T, P1, void>(
      (p1, _) => _getOverride<T>() ?? factoryFuncParam(p1),
      instanceName: instanceName,
    );
  }

  @override
  void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    getIt.registerSingleton(
      _getOverride<T>() ?? instance,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  @override
  void registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    getIt.registerLazySingleton(
      () => _getOverride<T>() ?? factoryFunc(),
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  @override
  T call<T extends Object>({String? instanceName}) => get(instanceName: instanceName);

  @override
  void allowReassignment() {
    getIt.allowReassignment = true;
  }

  Future<void> reset() {
    // _overrides.clear();

    return getIt.reset();
  }

  T? _getOverride<T>() {
    // if (!AppConfig.isDevMode) {
    //   return null;
    // }

    // final overrideProvider = _overrides[T];
    // if (overrideProvider != null) return overrideProvider() as T;

    return null;
  }
}
