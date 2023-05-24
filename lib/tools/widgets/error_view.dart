import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final Function() retry;

  const ErrorView({
    Key? key,
    required this.message,
    required this.retry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: retry,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const Icon(Icons.refresh),
        ],
      ),
    );
  }
}
