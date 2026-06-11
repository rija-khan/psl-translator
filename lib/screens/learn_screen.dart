import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/lesson.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────
// Data model for a category shown on Learn tab
// ─────────────────────────────────────────────
class _Category {
  const _Category({
    required this.title,
    required this.icon,
    required this.color,
    required this.lessonCount,
    required this.duration,
    required this.progress,
    required this.progressColor,
    required this.lessons,
  });

  final String title;
  final IconData icon;
  final Color color;
  final int lessonCount;
  final String duration;
  final double progress; // 0.0–1.0
  final Color progressColor;
  final List<Lesson> lessons;
}

// ─────────────────────────────────────────────
// LearnScreen — Categories overview
// ─────────────────────────────────────────────
class LearnScreen extends StatefulWidget {
  const LearnScreen({required this.onOpenLesson, super.key});

  final void Function(BuildContext context, List<Lesson> lessons, int index) onOpenLesson;

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  List<_Category> _buildCategories(AppLocalizations l10n) => [
        _Category(
          title: l10n.catBasicGreetings,
          icon: Icons.waving_hand_rounded,
          color: AppTheme.primary,
          lessonCount: 8,
          duration: l10n.catBasicGreetingsDuration,
          progress: 0.25,
          progressColor: Colors.redAccent,
          lessons: [
            Lesson(
              title: l10n.lessonHelloHi,
              category: l10n.catBasicGreetings,
              description: l10n.lessonHelloHiDesc,
              difficulty: l10n.beginner,
              thumbnailIcon: 'waving_hand',
              videoUrl: 'assets/sign_videos/hello.mp4',
              isUnlocked: true,
            ),
            Lesson(title: l10n.lessonThankYou, category: l10n.catBasicGreetings, description: l10n.lessonThankYouDesc, difficulty: l10n.beginner, thumbnailIcon: 'waving_hand'),
            Lesson(title: l10n.lessonPlease, category: l10n.catBasicGreetings, description: l10n.lessonPleaseDesc, difficulty: l10n.beginner, thumbnailIcon: 'waving_hand'),
            Lesson(title: l10n.lessonSorry, category: l10n.catBasicGreetings, description: l10n.lessonSorryDesc, difficulty: l10n.beginner, thumbnailIcon: 'waving_hand'),
            Lesson(title: l10n.lessonGoodMorning, category: l10n.catBasicGreetings, description: l10n.lessonGoodMorningDesc, difficulty: l10n.beginner, thumbnailIcon: 'waving_hand'),
            Lesson(title: l10n.lessonGoodNight, category: l10n.catBasicGreetings, description: l10n.lessonGoodNightDesc, difficulty: l10n.beginner, thumbnailIcon: 'waving_hand'),
            Lesson(title: l10n.lessonHowAreYou, category: l10n.catBasicGreetings, description: l10n.lessonHowAreYouDesc, difficulty: l10n.beginner, thumbnailIcon: 'waving_hand'),
            Lesson(title: l10n.lessonGoodbye, category: l10n.catBasicGreetings, description: l10n.lessonGoodbyeDesc, difficulty: l10n.beginner, thumbnailIcon: 'waving_hand'),
          ],
        ),
        _Category(
          title: l10n.catPslAlphabet,
          icon: Icons.text_fields_rounded,
          color: AppTheme.secondary,
          lessonCount: 26,
          duration: l10n.catPslAlphabetDuration,
          progress: 0.30,
          progressColor: AppTheme.accent,
          lessons: List.generate(
            26,
            (i) {
              final letter = String.fromCharCode(65 + i);
              final videoUrl = switch (letter) {
                'A' => 'assets/lesson_videos/a.mp4',
                'B' => 'assets/lesson_videos/b.mp4',
                _ => null,
              };
              return Lesson(
                title: '${l10n.lessonLetterPrefix} $letter',
                category: l10n.catPslAlphabet,
                description: '${l10n.lessonLetterDescPrefix} $letter',
                difficulty: l10n.beginner,
                thumbnailIcon: 'pin',
                videoUrl: videoUrl,
                isUnlocked: videoUrl != null,
              );
            },
          ),
        ),
        _Category(
          title: l10n.catFamilyPeople,
          icon: Icons.people_alt_rounded,
          color: AppTheme.accent,
          lessonCount: 12,
          duration: l10n.catFamilyPeopleDuration,
          progress: 0.10,
          progressColor: AppTheme.primary,
          lessons: [
            Lesson(title: l10n.lessonFamilyTitle, category: l10n.catFamilyPeople, description: l10n.lessonFamilyDescription, difficulty: l10n.beginner, thumbnailIcon: 'family_restroom'),
            Lesson(title: l10n.lessonMother, category: l10n.catFamilyPeople, description: l10n.lessonMotherDesc, difficulty: l10n.beginner, thumbnailIcon: 'family_restroom'),
            Lesson(title: l10n.lessonFather, category: l10n.catFamilyPeople, description: l10n.lessonFatherDesc, difficulty: l10n.beginner, thumbnailIcon: 'family_restroom'),
            Lesson(title: l10n.lessonSister, category: l10n.catFamilyPeople, description: l10n.lessonSisterDesc, difficulty: l10n.beginner, thumbnailIcon: 'family_restroom'),
            Lesson(title: l10n.lessonBrother, category: l10n.catFamilyPeople, description: l10n.lessonBrotherDesc, difficulty: l10n.beginner, thumbnailIcon: 'family_restroom'),
          ],
        ),
        _Category(
          title: l10n.catColorsShapes,
          icon: Icons.palette_rounded,
          color: const Color(0xFFEC4899),
          lessonCount: 15,
          duration: l10n.catColorsShapesDuration,
          progress: 0.0,
          progressColor: AppTheme.primary,
          lessons: [
            Lesson(title: l10n.lessonRed, category: l10n.catColorsShapes, description: l10n.lessonRedDesc, difficulty: l10n.beginner, thumbnailIcon: 'pin'),
            Lesson(title: l10n.lessonBlue, category: l10n.catColorsShapes, description: l10n.lessonBlueDesc, difficulty: l10n.beginner, thumbnailIcon: 'pin'),
            Lesson(title: l10n.lessonGreen, category: l10n.catColorsShapes, description: l10n.lessonGreenDesc, difficulty: l10n.beginner, thumbnailIcon: 'pin'),
            Lesson(title: l10n.lessonCircle, category: l10n.catColorsShapes, description: l10n.lessonCircleDesc, difficulty: l10n.beginner, thumbnailIcon: 'pin'),
            Lesson(title: l10n.lessonSquare, category: l10n.catColorsShapes, description: l10n.lessonSquareDesc, difficulty: l10n.beginner, thumbnailIcon: 'pin'),
          ],
        ),
        _Category(
          title: l10n.catNumbers,
          icon: Icons.pin_rounded,
          color: const Color(0xFF14B8A6),
          lessonCount: 20,
          duration: l10n.catNumbersDuration,
          progress: 0.50,
          progressColor: AppTheme.primary,
          lessons: List.generate(
            10,
            (i) => Lesson(
              title: '${l10n.lessonNumberPrefix} ${i + 1}',
              category: l10n.catNumbers,
              description: '${l10n.lessonNumberDescPrefix} ${i + 1}.',
              difficulty: l10n.beginner,
              thumbnailIcon: 'pin',
            ),
          ),
        ),
        _Category(
          title: l10n.catSchoolEducation,
          icon: Icons.school_rounded,
          color: const Color(0xFF6366F1),
          lessonCount: 18,
          duration: l10n.catSchoolEducationDuration,
          progress: 0.0,
          progressColor: AppTheme.primary,
          lessons: [
            Lesson(title: l10n.lessonSchoolTitle, category: l10n.catSchoolEducation, description: l10n.lessonSchoolDescription, difficulty: l10n.intermediate, thumbnailIcon: 'school'),
            Lesson(title: l10n.lessonTeacher, category: l10n.catSchoolEducation, description: l10n.lessonTeacherDesc, difficulty: l10n.intermediate, thumbnailIcon: 'school'),
            Lesson(title: l10n.lessonStudent, category: l10n.catSchoolEducation, description: l10n.lessonStudentDesc, difficulty: l10n.intermediate, thumbnailIcon: 'school'),
            Lesson(title: l10n.lessonBook, category: l10n.catSchoolEducation, description: l10n.lessonBookDesc, difficulty: l10n.intermediate, thumbnailIcon: 'school'),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categories = _buildCategories(l10n);
    final screenWidth = MediaQuery.of(context).size.width;
    final columns = screenWidth >= 900 ? 3 : 2;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Hero Banner ──────────────────────────────────────
          _HeroBanner(),
          const SizedBox(height: 16),

          // ── Progress Card ────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _ProgressOverviewCard(),
          ),
          const SizedBox(height: 24),

          // ── Categories heading ───────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.layers_rounded, color: AppTheme.primary, size: 22),
                const SizedBox(width: 8),
                Text(
                  l10n.categories,
                  style: const TextStyle(
                    color: AppTheme.textDark,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Category Grid ────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                return _CategoryCard(
                  category: cat,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _CategoryLessonScreen(
                          category: cat,
                          onOpenLesson: widget.onOpenLesson,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Hero Banner
// ─────────────────────────────────────────────
class _HeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF7C3AED), Color(0xFF9F5FFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: .08),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -30,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: .06),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                l10n.masterSignLanguage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.startLearningToday,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Progress Overview Card
// ─────────────────────────────────────────────
class _ProgressOverviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              const Icon(Icons.trending_up_rounded, color: AppTheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                l10n.yourProgress,
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Percentage row
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text(
                '45%',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  l10n.overallCompletion,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LinearProgressIndicator(
              value: 0.45,
              minHeight: 10,
              backgroundColor: Color(0xFFE5E7EB),
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
            ),
          ),
          const SizedBox(height: 14),

          // Stats row
          Row(
            children: [
              const Icon(Icons.check_circle, color: AppTheme.primary, size: 16),
              const SizedBox(width: 5),
              Text(
                l10n.completedCount(9, 20),
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              const Icon(Icons.access_time_rounded, color: AppTheme.primary, size: 16),
              const SizedBox(width: 5),
              Text(
                l10n.timeSpent('4h 30m'),
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Category Card (2-column grid item)
// ─────────────────────────────────────────────
class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category, required this.onTap});

  final _Category category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final percent = (category.progress * 100).round();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: category.color,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(category.icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 12),

            // Title
            Text(
              category.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppTheme.textDark,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),

            // Meta
            Text(
              '${category.lessonCount} ${l10n.lesson.toLowerCase()}s • ${category.duration}',
              style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
            ),
            const SizedBox(height: 10),

            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: category.progress,
                minHeight: 5,
                backgroundColor: const Color(0xFFE5E7EB),
                valueColor: AlwaysStoppedAnimation<Color>(category.progressColor),
              ),
            ),
            const SizedBox(height: 6),

            // Completion label
            Text(
              l10n.percentComplete(percent),
              style: TextStyle(
                color: category.progressColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Category Lesson Screen (second screenshot)
// ─────────────────────────────────────────────
class _CategoryLessonScreen extends StatelessWidget {
  const _CategoryLessonScreen({
    required this.category,
    required this.onOpenLesson,
  });

  final _Category category;
  final void Function(BuildContext context, List<Lesson> lessons, int index) onOpenLesson;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBF8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back, color: AppTheme.textDark, size: 20),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.title,
              style: const TextStyle(
                color: AppTheme.textDark,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              '${category.lessonCount} ${l10n.lesson.toLowerCase()}s • ${category.duration}',
              style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Section heading
          Row(
            children: [
              const Icon(Icons.format_list_bulleted_rounded, color: AppTheme.primary, size: 22),
              const SizedBox(width: 8),
              Text(
                l10n.lessonsInCategory,
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Lesson rows
          ...List.generate(category.lessons.length, (index) {
            final lesson = category.lessons[index];
            return _LessonRow(
              index: index,
              lesson: lesson,
              isCompleted: index < 3,
              onTap: () {
                if (!lesson.isUnlocked) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coming Soon')),
                  );
                  return;
                }
                onOpenLesson(context, category.lessons, index);
              },
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Lesson Row item
// ─────────────────────────────────────────────
class _LessonRow extends StatelessWidget {
  const _LessonRow({
    required this.index,
    required this.lesson,
    required this.isCompleted,
    required this.onTap,
  });

  final int index;
  final Lesson lesson;
  final bool isCompleted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isUnlocked = lesson.isUnlocked;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isUnlocked ? Colors.white : const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(14),
            border: Border(
              left: BorderSide(
                color: isUnlocked ? AppTheme.primary : const Color(0xFFD1D5DB),
                width: 3.5,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              // Number bubble
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isUnlocked ? AppTheme.primary : const Color(0xFFD1D5DB),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Title + subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ).copyWith(
                        color: isUnlocked ? AppTheme.textDark : const Color(0xFF9CA3AF),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      lesson.description,
                      style: TextStyle(
                        color: isUnlocked ? AppTheme.textMuted : const Color(0xFF9CA3AF),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // Duration + check
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isUnlocked ? Icons.access_time_rounded : Icons.lock,
                    color: isUnlocked ? AppTheme.primary : const Color(0xFF9CA3AF),
                    size: 15,
                  ),
                  const SizedBox(width: 3),
                  if (isUnlocked)
                    Text(
                      l10n.fourMin,
                      style: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
                    ),
                  const SizedBox(width: 8),
                  Icon(
                    isUnlocked ? Icons.check : Icons.lock,
                    color: isCompleted && isUnlocked ? AppTheme.primary : const Color(0xFFD1D5DB),
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
