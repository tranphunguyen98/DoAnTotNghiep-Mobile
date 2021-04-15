import 'package:flutter/cupertino.dart';

class CreatingHabitStep extends ChangeNotifier {
  static const int kStep1 = 0;
  static const int kStep2 = 1;

  CreatingHabitStep() {
    _index = kStep1;
  }

  int _index;

  set index(int index) {
    _index = index;
    notifyListeners();
  }

  int get index => _index;
}
