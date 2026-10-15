import 'package:flutter/material.dart';

// CUSTOM WIDGET: circular student photo.
// Put your photo at assets/images/profile.jpg
//
// HERO ANIMATION: the same heroTag is used on the Login page and the
// Dashboard. Flutter automatically "flies" the photo from one screen
// to the other during navigation.
class ProfileAvatar extends StatelessWidget {
  final double radius;
  const ProfileAvatar({super.key, this.radius = 50});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Hero(
      tag: 'profile-photo',
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: radius,
          backgroundColor: scheme.primaryContainer,
          backgroundImage: const AssetImage('assets/images/profile.jpg'),
          // If the image is missing, don't crash.
          onBackgroundImageError: (_, __) {},
        ),
      ),
    );
  }
}
