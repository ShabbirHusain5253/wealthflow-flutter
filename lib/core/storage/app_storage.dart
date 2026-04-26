import 'package:shared_preferences/shared_preferences.dart';
import 'package:wealthflow/core/storage/storage_constants.dart';

class AppStorage {
  final SharedPreferences _sharedPreferences;
  AppStorage(this._sharedPreferences);

  void saveToken(String token) async {
    await _sharedPreferences.setString(StorageConstants.token, token);
  }

  String? getToken() {
    return _sharedPreferences.getString(StorageConstants.token);
  }

  void login() async {
    await _sharedPreferences.setBool(StorageConstants.isLogin, true);
  }

  void logout() async {
    await _sharedPreferences.setBool(StorageConstants.isLogin, false);
  }

  Future<void> clear() async {
    await _sharedPreferences.clear();
  }

  void saveUser(String userJson) async {
    await _sharedPreferences.setString('user_data', userJson);
  }

  String? getUser() {
    return _sharedPreferences.getString('user_data');
  }

  bool isLogin() {
    return _sharedPreferences.getBool(StorageConstants.isLogin) ?? false;
  }
}
