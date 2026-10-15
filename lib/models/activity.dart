import 'package:flutter/material.dart';

// MODEL: one extra-curricular activity.
class Activity {
  final String title;
  final String description;
  final String year;
  final IconData icon;

  const Activity({
    required this.title,
    required this.description,
    required this.year,
    required this.icon,
  });
}
