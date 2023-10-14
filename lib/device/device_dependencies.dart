import 'package:bitsgap/core/di/dependencies.dart';
import 'package:bitsgap/core/di/di.dart';
import 'package:bitsgap/device/device.dart';
import 'package:bitsgap/domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceDependencies extends Dependencies {
  @override
  Future<void> register(DI di) async {
    final appKeyValueStorage = DeviceAppKeyValueStorage(
      sharedPreferences: await SharedPreferences.getInstance(),
      jsonStringConverter: di(),
    );

    di.registerSingleton<AppKeyValueStorage>(appKeyValueStorage);
  }
}
