import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isLightTheme = false;
  Color bgColorStart = Colors.lightBlue;
  Color bgColorEnd = Colors.blue;
  void changeTheme() {
    isLightTheme = !isLightTheme;
    bgColorStart = isLightTheme ? Colors.blueGrey : Colors.lightBlue;
    bgColorEnd = isLightTheme ? Colors.grey : Colors.blue;

    notifyListeners();
  }
}
