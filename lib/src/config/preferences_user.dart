import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUser {
  static final PreferencesUser _intancia = new PreferencesUser._intern();

  factory PreferencesUser() {
    return _intancia;
  }

  PreferencesUser._intern();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET - Theme
  int get theme => _prefs.getInt('theme') ?? 1;

  set theme(int value) {
    _prefs.setInt('theme', value);
  }
}
