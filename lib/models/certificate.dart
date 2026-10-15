import 'package:flutter/material.dart';

// MODEL: one certificate / course / skill entry.
class Certificate {
  final String title;
  final String organization;
  final String year;
  final String description;
  final IconData icon;

  /// Asset path of the certificate image. Use null if you have no image yet;
  /// the app then shows a placeholder dialog instead.
  final String? imagePath;

  const Certificate({
    required this.title,
    required this.organization,
    required this.year,
    required this.description,
    this.icon = Icons.workspace_premium,
    this.imagePath,
  });
}
