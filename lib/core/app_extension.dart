import 'package:flutter/material.dart';
import 'package:dental_care/src/data/model/dental_service.dart';
import 'package:dental_care/src/presentation/animation/fade_animation.dart';

extension ThemeDataExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension StringExtension on String {
  String get toCapital => this[0].toUpperCase() + substring(1, length);
}

extension WidgetExtension on Widget {
  Widget fadeAnimation(double delay) => FadeAnimation(delay: delay, child: this);
}

extension IterableExtension on List<DentalService> {
  int getIndex(DentalService food) {
    int index = indexWhere((element) => element.id == food.id);
    return index;
  }
}
