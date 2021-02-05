import 'package:flutter/material.dart';

// Preferences
import 'package:designs_app/src/config/preferences_user.dart';

class ThemeChanger with ChangeNotifier {
  // Prefs
  final prefs = PreferencesUser();

  // Themes
  final _themeLight = ThemeData.light();
  final __themeDark = ThemeData.dark().copyWith(accentColor: Colors.blue);
  final _themeCustom = ThemeData.dark().copyWith(accentColor: Colors.redAccent);

  // Provider
  bool _darkTheme = false;
  bool _customTheme = false;

  ThemeData _currentTheme;

  bool get darkTheme => this._darkTheme;
  bool get customTheme => this._customTheme;
  ThemeData get currentTheme => this._currentTheme;

  // Init app
  ThemeChanger(int theme) {
    switch (theme) {
      case 2: // Dark
        _darkTheme = true;
        _customTheme = false;
        _currentTheme = __themeDark;
        break;

      case 3: // Custom
        _darkTheme = false;
        _customTheme = true;
        _currentTheme = _themeCustom;
        break;

      default: // Light
        _darkTheme = false;
        _customTheme = false;
        _currentTheme = _themeLight;
        break;
    }
  }

  set darkTheme(bool value) {
    this._darkTheme = value;
    this._customTheme = false;

    // Save prefs
    prefs.theme = value ? 2 : 1;

    // Save provider
    _currentTheme = value ? __themeDark : _themeLight;

    notifyListeners();
  }

  set customTheme(bool value) {
    this._customTheme = value;
    this._darkTheme = false;

    // Save prefs
    prefs.theme = value ? 3 : 1;

    // Save provider
    _currentTheme = value ? _themeCustom : _themeLight;

    notifyListeners();
  }
}
