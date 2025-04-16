import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("Coming soon!"),
      ),
    );
  }
}
