import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  const AdaptativeTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.onSubmit,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final TextEditingController controller;
  final Function(String) onSubmit;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CupertinoTextField(
          controller: controller,
          onSubmitted: onSubmit,
          keyboardType: keyboardType,
          placeholder: label,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        ),
      );
    } else {
      return TextField(
        controller: controller,
        onSubmitted: onSubmit,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label),
      );
    }
  }
}
