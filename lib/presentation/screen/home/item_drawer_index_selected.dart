import 'package:flutter/foundation.dart';

class IndexSelectedChangeNotifier extends ChangeNotifier {
  int _indexSelected = 0;

  int get indexSelected => _indexSelected;

  void changeIndexSelected(int indexSelected) {
    _indexSelected = indexSelected;
    notifyListeners();
  }
}
