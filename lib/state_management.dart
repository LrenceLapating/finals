import 'package:flutter/material.dart';

class FitnessData with ChangeNotifier {
  int _activeMinutes = 0;
  double _hydration = 0.0;  // Track hydration in liters
  List<Map<String, dynamic>> _workouts = [];

  int get activeMinutes => _activeMinutes;
  double get hydration => _hydration;
  List<Map<String, dynamic>> get workouts => _workouts;

  void addActiveMinutes(int value) {
    _activeMinutes += value;
    notifyListeners();
  }

  void addHydration(double value) {
    _hydration += value;
    notifyListeners();
  }

  void completeWorkout(String type, int duration) {
    _workouts.add({'type': type, 'duration': duration});
    notifyListeners();
  }
}
