import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int current;
  final int total;

  const ProgressIndicatorWidget({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: current / total,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
          minHeight: 12,
          borderRadius: BorderRadius.circular(10),
        ),
        const SizedBox(height: 8),
        Text(
          'Question $current/$total',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}