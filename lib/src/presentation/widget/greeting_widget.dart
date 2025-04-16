import 'dart:async';

import 'package:dental_care/core/app_extension.dart';
import 'package:flutter/material.dart';

class GreetingScreen extends StatelessWidget {
  final StreamController<String> _greetingController =
      StreamController<String>();

  GreetingScreen({super.key}) {
    _updateGreeting();
    Timer.periodic(Duration(minutes: 1), (timer) => _updateGreeting());
  }

  void _updateGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 12) {
      _greetingController.add('Chào buổi sáng! 🌅');
    } else if (hour < 18) {
      _greetingController.add('Chào buổi chiều! ☀️');
    } else {
      _greetingController.add('Chào buổi tối! 🌙');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _greetingController.stream,
      initialData: 'Đang tải...',
      builder: (context, snapshot) {
        return Text(
          snapshot.data!,
          style: Theme.of(context).textTheme.headlineSmall,
        ).fadeAnimation(0.2);
      },
    );
  }
}
