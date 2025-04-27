import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppState extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  Future<void> loadState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentIndex = prefs.getInt('currentIndex') ?? 0;
    notifyListeners();
  }

  Future<void> saveCurrentIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentIndex', index);
    _currentIndex = index;
    notifyListeners();
  }
}
