import 'package:flutter/material.dart';

class LanguageRepository extends ChangeNotifier {
  bool _isEnglish = true;

  bool get isEnglish => _isEnglish;

  void changeLanguage() {
    _isEnglish = !_isEnglish;
    notifyListeners();
  }
}
