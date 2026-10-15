// MODEL: one slide of the achievements carousel.
class Achievement {
  final String title;
  final String description;

  /// Asset path of the image (null = gradient placeholder is shown).
  final String? imagePath;

  const Achievement({
    required this.title,
    required this.description,
    this.imagePath,
  });
}
