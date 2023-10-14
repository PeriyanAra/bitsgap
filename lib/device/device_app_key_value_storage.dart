import 'package:bitsgap/core/core.dart';
import 'package:bitsgap/domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceAppKeyValueStorage implements AppKeyValueStorage {
  DeviceAppKeyValueStorage({
    required SharedPreferences sharedPreferences,
    required JsonStringConverter jsonStringConverter,
  })  : _preferences = sharedPreferences,
        _jsonStringConverter = jsonStringConverter;

  final SharedPreferences _preferences;
  final JsonStringConverter _jsonStringConverter;

  @override
  Future<Set<String>> getKeys() async {
    return _preferences.getKeys();
  }

  @override
  Future<T?> read<T>(String key) async {
    final value = _preferences.getString(key);

    if (value == null) {
      return null;
    }

    return _jsonStringConverter.fromJsonString<T>(value);
  }

  @override
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  @override
  Future<void> write<T>(String key, T value) async {
    final stringValue = _jsonStringConverter.toJsonString(value);
    await _preferences.setString(key, stringValue);
  }
}
