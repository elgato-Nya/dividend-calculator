import 'package:flutter/material.dart';
import '../constants/app_styles.dart';

class ResultCard extends StatelessWidget {
  final double monthlyDividend;
  final double totalDividend;

  const ResultCard({
    super.key,
    required this.monthlyDividend,
    required this.totalDividend,
  });

  // Shows a dialog with the full value for copying
  void _showFullValue(BuildContext context, String label, String value) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(label),
        content: SelectableText(value),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;
    final onSurface = theme.colorScheme.onSurface;
    final surface = theme.colorScheme.surface;
    final secondaryContainer = theme.colorScheme.secondaryContainer;
    final onSecondaryContainer = theme.colorScheme.onSecondaryContainer;

    final monthlyStr = monthlyDividend.toString();
    final totalStr = totalDividend.toStringAsFixed(2);

    // Builds a row for each result value
    Widget buildRow(String label, IconData icon, String value) {
      final shortValue = value.length > 12 ? '${value.substring(0, 8)}…' : value;
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: surface.withAlpha((0.7 * 255).toInt()),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: secondary.withAlpha((0.12 * 255).toInt()),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(icon, color: secondary, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label, style: theme.textTheme.bodyLarge?.copyWith(color: onSurface, fontWeight: FontWeight.w600)),
            ),
            GestureDetector(
              onTap: () => _showFullValue(context, label, 'RM $value'),
              child: Row(
                children: [
                  Text(
                    'RM $shortValue',
                    textAlign: TextAlign.right,
                    style: theme.textTheme.titleMedium?.copyWith(color: primary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.info_outline, size: 18, color: secondary),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      margin: const EdgeInsets.symmetric(vertical: AppStyles.padding),
      color: secondaryContainer,
      shadowColor: secondary.withAlpha((0.08 * 255).toInt()),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.stacked_line_chart, color: secondary, size: 28),
                const SizedBox(width: 10),
                Text(
                  'Dividend Results',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: onSecondaryContainer,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            buildRow('Monthly Dividend', Icons.attach_money, monthlyStr),
            buildRow('Total Dividend', Icons.pie_chart, totalStr),
          ],
        ),
      ),
    );
  }
}
