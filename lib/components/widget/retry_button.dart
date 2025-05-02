import 'package:flutter/material.dart';
import 'package:news/const/colors.dart';

class RetryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RetryButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        icon: const Icon(Icons.refresh, color: Colors.white),
        label: const Text(
          "Retry",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
