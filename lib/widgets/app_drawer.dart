import 'package:flutter/material.dart';

// Notice: No more imports for share_plus or url_launcher!
// This widget is now "dumb" and just does what it's told.

class AppDrawer extends StatelessWidget {
  final VoidCallback? onShare;
  final VoidCallback? onFeedback;
  const AppDrawer({super.key, this.onShare, this.onFeedback});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A beautiful header that uses the app's primary color
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'TOUGHEST',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share the App'),
            // This now calls the function *passed in* from HomeScreen
            onTap: onShare,
          ),
          ListTile(
            leading: const Icon(Icons.bug_report_outlined),
            title: const Text('Send Feedback'),
            // This also calls the function from HomeScreen
            onTap: onFeedback,
          ),
          const Spacer(), // Pushes the version number to the bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('v2.0.2', style: Theme.of(context).textTheme.bodySmall),
          )
        ],
      ),
    );
  }
}
