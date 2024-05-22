import 'package:shared_preferences/shared_preferences.dart';

bool strongPassword(String password) {
  if (password.length <= 8) {
    return false;
  }
  return true;
}

class Preferences {
  late SharedPreferences pref;
  bool isError = false;
  String errorMsg = '';
  Preferences() {
    reset();
  }

  Future<void> reset() async {
    pref = await SharedPreferences.getInstance();
    errorMsg = '';
    isError = false;
  }

  Future<void> initSession(String userID, String userName) async {
    pref.setString("userID", userID);
    pref.setString("userName", userName);
  }

  Future<String?> loadUserID() async {
    return pref.getString("userID");
  }

  Future<String?> loadUserName() async {
    return pref.getString("userName");
  }

  Future<void> closeSession() async {
    await reset();
    pref.remove("userID");
    pref.remove("userName");
  }

  Future<bool> checkSession() async {
    return pref.containsKey("userID");
  }
}
