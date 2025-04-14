import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<void> setIsChecked(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  String? getString(String key) => _prefs.getString(key);

  bool? getIsChecked(String key) => _prefs.getBool(key);

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  static Future<void> initAndRegister() async {
    final prefs = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<LocalStorageService>(LocalStorageService(prefs));
  }
}