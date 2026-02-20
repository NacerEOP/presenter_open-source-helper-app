import 'package:flutter/material.dart';

class States extends ChangeNotifier {
  String _page = 'init';
  String get page => _page;

  void go(String pageName) {
    _page = pageName;
    notifyListeners();
  }
}
