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

  Future saveString(String key, String value) async {
    if (Keys.account == key) {
      await StorageManager.sharedPreferences.setString(key, value);
    }
  }

  Future saveInt(String key, int value) async {
    String account =
        StorageManager.sharedPreferences.getString(Keys.account) ?? "default";
    await StorageManager.sharedPreferences.setInt(key + account, value);
  }

  Future<List<String>> getStringList(String key) async {
    String account =
        StorageManager.sharedPreferences.getString(Keys.account) ?? "default";
    return StorageManager.sharedPreferences.getStringList(key + account);
  }

  Future saveStringList(String key, List<String> list) async {
    String account =
        StorageManager.sharedPreferences.getString(Keys.account) ?? "default";
    await StorageManager.sharedPreferences.setStringList(key + account, list);
  }
}
