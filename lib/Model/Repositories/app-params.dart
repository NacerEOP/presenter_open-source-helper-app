import '../Services/shared-preferences.dart';

class AppParamsRepository {
  final PreferencesService _prefs;

  AppParamsRepository(this._prefs);

  static const _themeKey = 'isDark';
  static const _langKey = 'language';
  static const _onboardingKey = 'onboardingSeen';

  // THEME
  Future<bool> getTheme() async {
    return await _prefs.getBool(_themeKey) ?? false;
  }

  Future<void> setTheme(bool value) async {
    await _prefs.setBool(_themeKey, value);
  }

  // LANGUAGE
  Future<String> getLanguage() async {
    return await _prefs.getString(_langKey) ?? 'en';
  }

  Future<void> setLanguage(String value) async {
    await _prefs.setString(_langKey, value);
  }

  // ONBOARDING
  Future<bool> getOnboardingSeen() async {
    return await _prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> setOnboardingSeen(bool value) async {
    await _prefs.setBool(_onboardingKey, value);
  }
}
