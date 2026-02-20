import 'package:flutter/material.dart';
import '../Model/Repositories/app-params.dart';

class ThemeViewModel extends ChangeNotifier {
  final AppParamsRepository _repo;

  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;

  ThemeViewModel(this._repo);

  Future<void> load() async {
    final isDark = await _repo.getTheme();
    _mode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> setMode(ThemeMode mode) async {
    _mode = mode;
    notifyListeners();
    await _repo.setTheme(mode == ThemeMode.dark);
  }
}
