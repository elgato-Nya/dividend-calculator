import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_styles.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String _repoUrl = 'https://github.com/elgato-Nya/dividend-calculator';

Future<void> _launchRepo(BuildContext context) async {
  final uri = Uri.parse(_repoUrl);
  final messenger = ScaffoldMessenger.of(context);

  final canLaunch = await canLaunchUrl(uri);
  debugPrint('Trying to launch $_repoUrl — Can launch? $canLaunch');

  if (canLaunch) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    messenger.showSnackBar(
      const SnackBar(content: Text('Could not launch URL')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final surface = theme.colorScheme.surface;
    final onPrimary = theme.colorScheme.onPrimary;
    final primaryContainer = theme.colorScheme.primaryContainer;
    final onPrimaryContainer = theme.colorScheme.onPrimaryContainer;
    final secondaryContainer = theme.colorScheme.secondaryContainer;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: surface,
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
        backgroundColor: primary,
        elevation: 0,
        foregroundColor: onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.code),
            tooltip: 'GitHub',
            color: onPrimary,
            onPressed: () => _launchRepo(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppStyles.padding,
              vertical: AppStyles.padding * 1.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App Icon & Title
                Center(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              primaryContainer.withAlpha((0.18 * 255).round()),
                              secondaryContainer.withAlpha((0.13 * 255).round())
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primary.withAlpha((0.14 * 255).toInt()),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/icon.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Unit Trust Dividend Calculator',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: primary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Calculate and track your unit trust dividends easily.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: onSurface.withAlpha((0.7 * 255).round()),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppStyles.padding * 2),

                // Features Card
                _Card(
                  padding: const EdgeInsets.all(AppStyles.padding * 1.2),
                  color: primaryContainer,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                    children: [
                        Icon(Icons.star_rounded, color: Color.fromARGB(255, 235, 196, 23), size: 28),
                      const SizedBox(width: 10),
                      Text(
                      'Key Features',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 21,
                        letterSpacing: 0.5,
                        color: onPrimaryContainer,
                      ),
                      ),
                    ],
                    ),
                    const SizedBox(height: 7),
                    _featureItem('Fast and easy dividend calculations', theme),
                    _featureItem('Save and manage multiple records', theme),
                    _featureItem('Clean, intuitive interface', theme),
                    _featureItem('100% offline, no data collection', theme),
                  ],
                  ),
                ),

                const SizedBox(height: AppStyles.padding * 0.5),

                // Developer Info Card
                _Card(
                  color: primaryContainer.withAlpha((0.7 * 255).round()),
                  child: Row(
                  children: [
                    CircleAvatar(
                    radius: 28,
                    backgroundColor: secondaryContainer,
                    child: ClipOval(
                      child: Image.asset(
                      'assets/choki_mad.jpg',
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      ),
                    ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text('elgato-Nya', style: theme.textTheme.bodyLarge?.copyWith(fontSize: 21, fontWeight: FontWeight.w700, color: onSurface)),
                      Text('Matric No: 2023197751', style: theme.textTheme.bodyMedium?.copyWith(color: onSurface.withAlpha((0.8 * 255).round()))),
                      Text('Course: Mobile Techonlogy & Development', style: theme.textTheme.bodyMedium?.copyWith(color: onSurface.withAlpha((0.8 * 255).round()))),
                      ],
                    ),
                    ),
                  ],
                  ),
                ),
                const SizedBox(height: AppStyles.padding * 0.5),

                // App Purpose / Info
                _Card(
                  color: primaryContainer,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline, color: onPrimaryContainer, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'This app is developed as part of a Mobile Technology & Development course project. '
                          'It is open-source and contributions are welcome!',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: onPrimaryContainer.withAlpha((0.9 * 255).round(),
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppStyles.padding * 0.5),

                // GitHub Button
                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () => _launchRepo(context),
                    icon: const Icon(Icons.code),
                    label: const Text('View Source on GitHub'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: onPrimary,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      shadowColor: primary.withAlpha((0.12 * 255).round()),
                    ),
                  ),
                ),

                const SizedBox(height: AppStyles.padding * 1.5),

                // Copyright
                Text(
                  '© ${DateTime.now().year} elgato-Nya',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(color: onSurface.withAlpha((0.6 * 255).round())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _featureItem(String text, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.check_circle_rounded, color: Color.fromARGB(255, 5, 161, 15), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.w500, color: theme.colorScheme.onPrimaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const _Card({
    required this.child,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: color ?? theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      elevation: 1.5,
      shadowColor: theme.colorScheme.shadow.withOpacity(0.04),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppStyles.padding),
        child: child,
      ),
    );
  }
}
