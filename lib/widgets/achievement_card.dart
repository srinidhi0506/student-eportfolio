import 'package:flutter/material.dart';
import '../models/achievement.dart';
import 'app_card.dart';

// CUSTOM WIDGET: one slide of the achievements carousel.
class AchievementCard extends StatelessWidget {
  final Achievement achievement;
  const AchievementCard({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: AppCard(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Expanded: the image uses all the space left above the text.
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: double.infinity,
                  color: scheme.primaryContainer,
                  child: achievement.imagePath == null
                      ? _trophy(scheme)
                      : Image.asset(
                          achievement.imagePath!,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => _trophy(scheme),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(achievement.title,
                textAlign: TextAlign.center, style: textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(achievement.description,
                textAlign: TextAlign.center, style: textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _trophy(ColorScheme scheme) {
    return Center(
      child: Icon(Icons.emoji_events, size: 72, color: scheme.primary),
    );
  }
}
