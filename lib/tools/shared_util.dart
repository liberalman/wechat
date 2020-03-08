import '../config/keys.dart';
import '../config/storage_manager.dart';

class SharedUtil {
  static SharedUtil _instance;

  //factory SharedUtil() => getInstance();

  static SharedUtil getInstance() {
    if (_instance == null) {
      _instance = new SharedUtil();
    }
    return _instance;
  }

  Future<String> getString(String key) async {
    if (key == Keys.userId) {
      return StorageManager.sharedPreferences.getString(key);
    }
    String userId =
        StorageManager.sharedPreferences.getString(Keys.userId) ?? "default";
    return StorageManager.sharedPreferences.getString(key + userId);
  }

  // userId must set at first
  Future saveString(String key, String value) async {
    if (key == Keys.userId) {
      await StorageManager.sharedPreferences.setString(key, value);
      return;
    }
    String userId =
        StorageManager.sharedPreferences.getString(Keys.userId) ?? "default";
    await StorageManager.sharedPreferences.setString(key + userId, value);
  }

  Future saveInt(String key, int value) async {
    String userId =
        StorageManager.sharedPreferences.getString(Keys.userId) ?? "default";
    await StorageManager.sharedPreferences.setInt(key + userId, value);
  }

  Future<List<String>> getStringList(String key) async {
    String userId =
        StorageManager.sharedPreferences.getString(Keys.userId) ?? "default";
    return StorageManager.sharedPreferences.getStringList(key + userId);
  }

  Future saveStringList(String key, List<String> list) async {
    String userId =
        StorageManager.sharedPreferences.getString(Keys.userId) ?? "default";
    await StorageManager.sharedPreferences.setStringList(key + userId, list);
  }

  Future saveBoolean(String key, bool value) async {
    String userId =
        StorageManager.sharedPreferences.getString(Keys.userId) ?? "default";
    await StorageManager.sharedPreferences.setBool(key + userId, value);
  }

  Future<bool> getBoolean(String key) async {
    String userId =
        StorageManager.sharedPreferences.getString(Keys.userId) ?? "default";
    return StorageManager.sharedPreferences.getBool(key + userId) ?? false;
  }
}
