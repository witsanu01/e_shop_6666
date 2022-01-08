import 'package:flutter/cupertino.dart';

class TotalPoints extends ChangeNotifier {
  double _totalPoints = 0;

  double get totalPoints => _totalPoints;

  display(double no) async {
    _totalPoints = no;

    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
