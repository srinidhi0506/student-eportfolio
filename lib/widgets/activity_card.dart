import 'package:flutter/material.dart';
import '../models/activity.dart';
import 'app_card.dart';

// CUSTOM WIDGET: one row in the Extra-Curricular list.
class ActivityCard extends StatelessWidget {
  final Activity activity;
  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: scheme.primaryContainer,
            child: Icon(activity.icon, color: scheme.primary),
          ),
          const SizedBox(width: 16),
          // Expanded makes the text take the remaining width (no overflow).
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.title, style: textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(activity.description, style: textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Chip(label: Text(activity.year)),
        ],
      ),
    );
  }
}
