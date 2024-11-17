import 'package:flutter/material.dart';

class NoteGridItemViewModel extends ChangeNotifier {
  bool _isActiveActions = false;
  bool get isActiveActions => this._isActiveActions;

  void activeOpacity() {
    _isActiveActions = !_isActiveActions;
    notifyListeners();
  }
}