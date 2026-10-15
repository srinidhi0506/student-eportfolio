import 'package:flutter/material.dart';
import '../data/achievements.dart';
import '../data/activities.dart';
import '../data/certificates.dart';
import '../models/student.dart';
import '../widgets/academic_table.dart';
import '../widgets/achievement_card.dart';
import '../widgets/activity_card.dart';
import '../widgets/app_card.dart';
import '../widgets/certificate_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/fade_slide_in.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/quote_card.dart';

// DASHBOARD: holds the 5 sections. [_selectedIndex] decides which one shows.
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0; // changed with setState()

  static const _titles = [
    'Academic Details',
    'Certifications & Skills',
    'Extra-Curricular Activities',
    'Achievements',
    'Logout',
  ];
  static const _labels = ['Academics', 'Skills', 'Activities', 'Awards', 'Logout'];
  static const _icons = [
    Icons.school_outlined,
    Icons.workspace_premium_outlined,
    Icons.groups_outlined,
    Icons.emoji_events_outlined,
    Icons.logout,
  ];
  static const _selectedIcons = [
    Icons.school,
    Icons.workspace_premium,
    Icons.groups,
    Icons.emoji_events,
    Icons.logout,
  ];

  Widget _currentTab() {
    switch (_selectedIndex) {
      case 0:
        return const AcademicTab();
      case 1:
        return const CertificatesTab();
      case 2:
        return const ActivitiesTab();
      case 3:
        return const AchievementsTab();
      default:
        return LogoutTab(onLogout: _confirmLogout);
    }
  }

  // Confirmation dialog -> clears the whole navigation stack on "Yes".
  Future<void> _confirmLogout() async {
    final bool? yes = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('No'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(80, 40)),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (yes == true && mounted) {
      // (route) => false removes ALL previous routes, so the Back button
      // cannot return to the dashboard.
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery gives the screen size -> choose phone or tablet layout.
    final bool isWide = MediaQuery.of(context).size.width >= 800;

    // ANIMATION: AnimatedSwitcher cross-fades when the tab changes.
    final content = AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: KeyedSubtree(
        key: ValueKey<int>(_selectedIndex),
        child: _currentTab(),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      body: isWide
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  labelType: NavigationRailLabelType.all,
                  onDestinationSelected: (i) =>
                      setState(() => _selectedIndex = i),
                  destinations: [
                    for (int i = 0; i < _labels.length; i++)
                      NavigationRailDestination(
                        icon: Icon(_icons[i]),
                        selectedIcon: Icon(_selectedIcons[i]),
                        label: Text(_labels[i]),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: content),
              ],
            )
          : content,
      // On phones we use the bottom NavigationBar (Material 3).
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (i) => setState(() => _selectedIndex = i),
              destinations: [
                for (int i = 0; i < _labels.length; i++)
                  NavigationDestination(
                    icon: Icon(_icons[i]),
                    selectedIcon: Icon(_selectedIcons[i]),
                    label: _labels[i],
                  ),
              ],
            ),
    );
  }
}

// ---------------------------------------------------------------------
// TAB 1: ACADEMIC DETAILS
// ---------------------------------------------------------------------
class AcademicTab extends StatelessWidget {
  const AcademicTab({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    const student = currentStudent;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.topCenter,
        // maxWidth keeps the content readable on tablets / desktops.
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              FadeSlideIn(
                child: AppCard(
                  child: Row(
                    children: [
                      const ProfileAvatar(radius: 38), // Hero from login
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(student.name, style: textTheme.titleLarge),
                            const SizedBox(height: 4),
                            Text(student.rollNo,
                                style: textTheme.titleSmall
                                    ?.copyWith(color: scheme.primary)),
                            const SizedBox(height: 4),
                            Text(student.year, style: textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const FadeSlideIn(
                index: 1,
                child: AcademicTable(student: student),
              ),
              const SizedBox(height: 16),
              const FadeSlideIn(index: 2, child: QuoteCard()),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// TAB 2: CERTIFICATES  (1 / 2 / 3 columns depending on width)
// ---------------------------------------------------------------------
class CertificatesTab extends StatelessWidget {
  const CertificatesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final int columns = width >= 900 ? 3 : (width >= 600 ? 2 : 1);
        const double gap = 16;
        const double pad = 16;
        final double itemWidth =
            (width - pad * 2 - gap * (columns - 1)) / columns;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(pad),
          child: Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (int i = 0; i < certificates.length; i++)
                SizedBox(
                  width: itemWidth,
                  child: FadeSlideIn(
                    index: i,
                    child: CertificateCard(certificate: certificates[i]),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------
// TAB 3: EXTRA-CURRICULAR ACTIVITIES (ListView)
// ---------------------------------------------------------------------
class ActivitiesTab extends StatelessWidget {
  const ActivitiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: activities.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) => FadeSlideIn(
            index: i,
            child: ActivityCard(activity: activities[i]),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// TAB 4: ACHIEVEMENTS (PageView carousel + video button)
// ---------------------------------------------------------------------
class AchievementsTab extends StatefulWidget {
  const AchievementsTab({super.key});

  @override
  State<AchievementsTab> createState() => _AchievementsTabState();
}

class _AchievementsTabState extends State<AchievementsTab>
    with SingleTickerProviderStateMixin {
  // viewportFraction < 1 lets the neighbouring slides peek in.
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0; // used by the dots

  // Controller for FadeTransition + SlideTransition of the video card.
  late final AnimationController _introController;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fade = CurvedAnimation(parent: _introController, curve: Curves.easeIn);
    _slide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(CurvedAnimation(parent: _introController, curve: Curves.easeOut));
    _introController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _introController.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    if (page < 0 || page >= achievements.length) return;
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Carousel takes all remaining height (Expanded).
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: achievements.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              // PAGE TRANSITION: the slide shrinks slightly when it is
              // not the centred page (scale between 0.85 and 1.0).
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double scale = 1.0;
                  if (_pageController.hasClients &&
                      _pageController.position.hasPixels &&
                      _pageController.position.hasContentDimensions) {
                    final double page = _pageController.page ?? 0;
                    scale = (1 - (page - index).abs() * 0.15).clamp(0.85, 1.0).toDouble();
                  }
                  return Transform.scale(scale: scale, child: child);
                },
                child: AchievementCard(achievement: achievements[index]),
              );
            },
          ),
        ),

        // Previous | dots | Next
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              tooltip: 'Previous',
              icon: const Icon(Icons.chevron_left),
              onPressed: _currentPage == 0 ? null : () => _goTo(_currentPage - 1),
            ),
            for (int i = 0; i < achievements.length; i++)
              // ANIMATION: AnimatedContainer smoothly changes width/colour
              // when the selected dot changes.
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: i == _currentPage ? 24 : 8,
                decoration: BoxDecoration(
                  color: i == _currentPage ? scheme.primary : scheme.outlineVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            IconButton(
              tooltip: 'Next',
              icon: const Icon(Icons.chevron_right),
              onPressed: _currentPage == achievements.length - 1
                  ? null
                  : () => _goTo(_currentPage + 1),
            ),
          ],
        ),

        // "Watch My Achievements" card (fades and slides in).
        FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: CustomButton(
                    label: 'Watch My Achievements',
                    icon: Icons.play_circle_fill,
                    // Named route -> VideoPage
                    onPressed: () => Navigator.pushNamed(context, '/video'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------
// TAB 5: LOGOUT
// ---------------------------------------------------------------------
class LogoutTab extends StatelessWidget {
  final VoidCallback onLogout;
  const LogoutTab({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: AppCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.logout, size: 56, color: scheme.primary),
                const SizedBox(height: 16),
                Text('Ready to leave?', style: textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(
                  'You will return to the login page.',
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                CustomButton(
                  label: 'Logout',
                  icon: Icons.logout,
                  onPressed: onLogout,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
