import 'package:flutter/cupertino.dart';

class TotalPoints extends ChangeNotifier {
  double _totalPoint = 0;

  double get totaPoints => _totalPoint;

  display(double no) async {
    _totalPoint = no;

    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
