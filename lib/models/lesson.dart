class Lesson {
  const Lesson({
    required this.title,
    required this.category,
    required this.description,
    required this.difficulty,
    required this.thumbnailIcon,
    this.videoUrl,
    this.isUnlocked = false,
  });

  final String title;
  final String category;
  final String description;
  final String difficulty;
  final String thumbnailIcon;
  final String? videoUrl;
  final bool isUnlocked;
}
