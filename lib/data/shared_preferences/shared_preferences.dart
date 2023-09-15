import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefernces {
  static SharedPreferences? _preferences;
  static const String key = 'userType';

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> userSaveType(String userType) async {
    await _preferences!.setString(key, userType);
  }

  static Future<String?> getUserType() async {
    return _preferences!.getString(key);
  }
}
