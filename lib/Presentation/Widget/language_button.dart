import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const LanguageButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(text, style: const TextStyle(fontSize: 16)),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
        onPressed: onTap,
      ),
    );
  }
}