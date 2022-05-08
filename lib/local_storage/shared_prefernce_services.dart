import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static late final SharedPreferences _preferences;

  final String _firstTimeLogged = "firstTimeLogged";

  final String isLogin = "isLogin";

  final String _email = "email";
  final String _password = "password";

  static Future<void> getInstance() async {
    _instance ??= LocalStorageService();
    _preferences = await SharedPreferences.getInstance();
  }

  bool? get firstTimeLogged => _preferences.getBool(_firstTimeLogged);

  bool? get login => _preferences.getBool(isLogin);

  String? get email => _preferences.getString(_email);

  String? get password => _preferences.getString(_password);

  set login(bool? value) {
    if (value == null) {
      _preferences.remove(isLogin);
      return;
    }
    _preferences.setBool(isLogin, value);
  }

  set firstTimeLogged(bool? value) {
    if (value == null) {
      _preferences.remove(_firstTimeLogged);
      return;
    }
    _preferences.setBool(_firstTimeLogged, value);
  }

  set email(String? value) {
    if (value == null) {
      _preferences.remove(_email);
      return;
    }
    _preferences.setString(_email, value);
  }

  set password(String? value) {
    if (value == null) {
      _preferences.remove(_password);
      return;
    }
    _preferences.setString(_password, value);
  }

  LogOut() {
    _preferences.remove(_password);
    _preferences.remove(_email);
    _preferences.remove(isLogin);
  }
}
