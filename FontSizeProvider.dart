import 'package:flutter/material.dart';

class FontSizeProvider extends ChangeNotifier {
  String _fontSize = "Medium";

  String get fontSize => _fontSize;

  void setFontSize(String newSize) {
    if (newSize != _fontSize) {
      _fontSize = newSize;
      notifyListeners();
    }
  }

  double get fontSizeValue {
    switch (_fontSize) {
      case "Small":
        return 14.0;
      case "Large":
        return 22.0;
      default:
        return 18.0;
    }
  }
}
