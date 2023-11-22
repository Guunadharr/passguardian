import 'package:dbcrypt/dbcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configs.dart';

class SharedPreferencesUtil {
  static bool savePinEnabled = true;
  static bool saveBiometricEnabled = true;

  static Future<void> savePin(String pin) async {
    if (savePinEnabled) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(SECURITY, "pin");
      await prefs.setBool(pinSetupKey, true);
      await prefs.setString(PIN_KEY, pin);
    }
  }

  static Future<bool> isPinSetup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(pinSetupKey) ?? false;
  }

  static Future<String?> getPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PIN_KEY);
  }

  static String hashPin(String pin) {
    DBCrypt bcrypt = DBCrypt();
    return bcrypt.hashpw(pin, bcrypt.gensalt());
  }

  static Future<void> setBiometric() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SECURITY, "biometric");
  }

  static Future<String?> getSecurityType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SECURITY);
  }

  static Future<bool> sharedPrefClearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
