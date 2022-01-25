import 'package:get_storage/get_storage.dart';

class SnoseyStorageManager {
  static GetStorage prefs = GetStorage();

  static saveData(String key, dynamic value) {
    prefs.write(key, value);
    prefs.save();
  }

  static dynamic readData(String key, dynamic defaultValue) {
    if (prefs.hasData(key)) {
      return prefs.read(key);
    }
    return defaultValue;
  }

  static bool containData(String key) {
    return prefs.hasData(key);
  }

  static deleteData(String key) {
    prefs.remove(key);
    prefs.save();
  }
}
