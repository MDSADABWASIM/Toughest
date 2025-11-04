import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toughest/ui/detail.dart';
import 'package:toughest/widgets/aniimated_carousel.dart';
import 'package:toughest/widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // Use a ScaffoldKey to control the standard Flutter Drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<_Category> _categories = [
    _Category(
        title: 'Behavioural Based',
        color: const Color(0xFFF1B136),
        icon: Icons.person_outline),
    _Category(
        title: 'Communications Based',
        color: const Color(0xFF885F7F),
        icon: Icons.wc_outlined),
    _Category(
        title: 'Opinion Based',
        color: const Color(0xFF13B0A5),
        icon: Icons.call_split_outlined),
    _Category(
        title: 'Performance Based',
        color: const Color(0xFFD0C490),
        icon: Icons.assessment_outlined),
    _Category(
        title: 'Brainteasers',
        color: const Color(0xFFEF6363),
        icon: Icons.help_outline),
  ];

  @override
  Widget build(BuildContext context) {
    // We replaced SideMenu with a standard Scaffold. It's cleaner.
    return Scaffold(
      key: _scaffoldKey,
      // The AppDrawer is now passed to the Scaffold's 'drawer' property.
      // We pass the *actual* functions to the drawer, so the logic stays in one place.
      drawer: AppDrawer(onShare: _onShare, onFeedback: _onFeedback),
      appBar: AppBar(
        leading: LayoutBuilder(builder: (context, constraints) {
          // Show hamburger only on small widths (mobile)
          if (constraints.maxWidth < 800) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // This now opens the standard Scaffold drawer
                _scaffoldKey.currentState?.openDrawer();
              },
            );
          }
          return const SizedBox.shrink(); // Hide on wide screens
        }),
        title: const Text('TOUGHEST'),
        actions: [
          LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth >= 800) {
              return Row(children: [
                TextButton(onPressed: () {}, child: const Text('Home')),
                TextButton(onPressed: () {}, child: const Text('About')),
                const SizedBox(width: 16)
              ]);
            }
            return const SizedBox.shrink();
          })
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        // -----------------
        // 🖥️ Desktop Layout
        // -----------------
        if (constraints.maxWidth >= 1000) {
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Learn. Practice. Perfect.',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: _buildCategoryGrid(
                          crossAxisCount: 1,
                          aspectRatio: 2.8, // Taller items for sidebar
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: AnimatedCarousel(key: const Key('carousel')),
                ),
              ),
            ],
          );
        }

        // -----------------
        // 📱 Tablet Layout
        // -----------------
        if (constraints.maxWidth >= 600) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Larger carousel for tablets
                  SizedBox(height: 400, child: AnimatedCarousel()),
                  const SizedBox(height: 24),
                  _buildCategoryGrid(crossAxisCount: 2, aspectRatio: 1.8),
                ],
              ),
            ),
          );
        }

        // -----------------
        // 🤳 Mobile Layout
        // -----------------
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Taller carousel for mobile
            SizedBox(height: 300, child: AnimatedCarousel()),
            const SizedBox(height: 16),
            _buildCategoryGrid(crossAxisCount: 1, aspectRatio: 1.8),
          ],
        );
      }),
    );
  }

  Widget _buildCategoryGrid(
      {int crossAxisCount = 1, double aspectRatio = 1.6}) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(), // Use Clamping instead of Never
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: aspectRatio,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final cat = _categories[index];
        // We use Card -> InkWell for a much cleaner look and feel.
        // InkWell gives us hover (desktop) and ripple (mobile) effects.
        return Card(
          elevation: 6,
          shadowColor: cat.color.withValues(alpha: 0.4),
          child: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DetailScreen(title: cat.title))),
            hoverColor: Colors.white.withValues(alpha: 0.1),
            splashColor: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                // A more subtle, elegant gradient
                gradient: LinearGradient(
                  colors: [cat.color.withValues(alpha: 0.85), cat.color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(cat.icon, size: 64, color: Colors.white),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        cat.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // --- Actions ---
  // These now live *only* in the HomeScreen and are passed to the drawer.

  void _onShare() async {
    // Close the drawer first if it's open
    _scaffoldKey.currentState?.closeDrawer();

    await SharePlus.instance.share(
      ShareParams(
        text: "Skills 101/TOUGHEST - Test your knowledge.\n"
            "The app that will make you an amazing candidate for any job.\n"
            "Are you ready?\n"
            "Download it now\n"
            "https://play.google.com/store/apps/details?id=tricky.questions",
        subject: "Check out TOUGHEST!",
      ),
    );
  }

  void _onFeedback() async {
    _scaffoldKey.currentState?.closeDrawer();

    final Uri url = Uri.parse(
        'mailto:indiancoder001@gmail.com?subject=Feedback&body=Feedback for Toughest');
    if (!await launchUrl(url)) {
      // In a real app, show a snackbar error
      debugPrint('Could not launch $url');
    }
  }
}

class _Category {
  final String title;
  final Color color;
  final IconData icon;
  _Category({required this.title, required this.color, required this.icon});
}
