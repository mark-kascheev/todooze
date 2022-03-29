import 'package:flutter/material.dart';

class BlurNotifier extends ValueNotifier<bool?> {
  BlurNotifier(bool? value) : super(value);

  void blurScreen() {
    value = true;
    notifyListeners();
  }

  void unBlurScreen() {
    value = false;
    notifyListeners();
  }
}
