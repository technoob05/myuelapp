import 'package:flutter/material.dart';

class AnalyticsProvider with ChangeNotifier {
  double _gpa = 8.45;
  int _creditsEarned = 110;
  final int _totalCredits = 120;

  final List<Map<String, dynamic>> _chartData = [
    {'day': 'T2', 'value': 40.0, 'active': false},
    {'day': 'T3', 'value': 60.0, 'active': false},
    {'day': 'T4', 'value': 30.0, 'active': false},
    {'day': 'T5', 'value': 80.0, 'active': false},
    {'day': 'T6', 'value': 50.0, 'active': false},
    {'day': 'T7', 'value': 90.0, 'active': false},
    {'day': 'CN', 'value': 20.0, 'active': false},
  ];

  double get gpa => _gpa;
  int get creditsEarned => _creditsEarned;
  int get totalCredits => _totalCredits;
  double get creditProgress => _creditsEarned / _totalCredits;

  List<Map<String, dynamic>> get chartData => _chartData;

  void simulateAppUsage(int activeDayIndex) {
    // Increase active day bar slightly to simulate usage
    if (activeDayIndex >= 0 && activeDayIndex < _chartData.length) {
      var currentValue = _chartData[activeDayIndex]['value'] as double;
      // Cap at 100
      if (currentValue < 100.0) {
        _chartData[activeDayIndex]['value'] = (currentValue + 10.0).clamp(
          0.0,
          100.0,
        );
      }
      _chartData[activeDayIndex]['active'] = true;
      notifyListeners();
    }
  }
}
