import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freesmoking/screens/cards/cards_screen.dart';

import '../screens/home/home_screen.dart';
import '../screens/info/info_screen.dart';

class AppMainProvider with ChangeNotifier, DiagnosticableTreeMixin {
////////////////    BOTTON NAV BAR    ////////////////////
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  set selectedIndex(value) => _selectedIndex = value;

  static List<Widget> widgetOptions = <Widget>[
    HomePage(),
    const InfoScreen(),
    const CardsScreen(),
  ];

  void changeIndex(int newValue) {
    _selectedIndex = newValue;
    notifyListeners();
  }

  getCurrentScreen() {
    return widgetOptions[_selectedIndex];
  }
}
