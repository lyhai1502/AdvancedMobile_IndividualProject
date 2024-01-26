import 'package:flutter/material.dart';

class BrightnessRepository extends ChangeNotifier {
  Brightness _brightness = Brightness.light;

  Brightness get brightness => _brightness;

  get isDarkModeOn => _brightness == Brightness.dark;

  void changeBrightness() {
    _brightness =
        _brightness == Brightness.light ? Brightness.dark : Brightness.light;
    notifyListeners();
  }
}
