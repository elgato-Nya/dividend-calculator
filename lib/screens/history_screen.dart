import 'package:flutter/material.dart';
import '../constants/app_styles.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> history;
  const HistoryScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final onPrimary = theme.colorScheme.onPrimary;
    final secondary = theme.colorScheme.secondary;
    final surface = theme.colorScheme.surface;
    final primaryContainer = theme.colorScheme.primaryContainer;
    final onPrimaryContainer = theme.colorScheme.onPrimaryContainer;
    final secondaryContainer = theme.colorScheme.secondaryContainer;
    final onSecondaryContainer = theme.colorScheme.onSecondaryContainer;

    return Scaffold(
      backgroundColor: surface,
      appBar: AppBar(
        title: const Text('Calculation History'),
        centerTitle: true,
        backgroundColor: primary,
        elevation: 0,
        foregroundColor: onPrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppStyles.padding,
            vertical: AppStyles.padding * 1.5,
          ),
          // Show message if history is empty, otherwise show list
          child: history.isEmpty
              ? Center(
                  child: Text(
                    'No calculation history yet.',
                    style: theme.textTheme.bodyLarge?.copyWith(color: secondary),
                  ),
                )
              : ListView.separated(
                  itemCount: history.length > 10 ? 10 : history.length, // Limit to 10 records
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, i) {
                    final record = history[i];
                    final number = i + 1;
                    return Card(
                      color: secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 1.5,
                      shadowColor: secondary.withAlpha((0.04 * 255).round()),
                      child: Padding(
                        padding: const EdgeInsets.all(AppStyles.padding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Fund amount and record number
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: primaryContainer,
                                  child: Text(
                                    '$number',
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      color: onPrimaryContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Fund: RM${(record['fund'] as double).toStringAsFixed(2)}',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: onSecondaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Rate and months
                            Row(
                              children: [
                                Icon(Icons.percent, color: primary, size: 20),
                                const SizedBox(width: 6),
                                Text('Rate: ${(record['rate'] as double).toStringAsFixed(2)}%', style: theme.textTheme.bodyMedium?.copyWith(color: onSecondaryContainer)),
                                const SizedBox(width: 18),
                                Icon(Icons.calendar_today, color: primary, size: 18),
                                const SizedBox(width: 6),
                                Text('Months: ${record['months']}', style: theme.textTheme.bodyMedium?.copyWith(color: onSecondaryContainer)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Monthly and total dividend
                            Row(
                              children: [
                                Icon(Icons.attach_money, color: primary, size: 20),
                                const SizedBox(width: 6),
                                Text('Monthly: RM${(record['monthlyDividend'] as double).toStringAsFixed(2)}', style: theme.textTheme.bodyMedium?.copyWith(color: onSecondaryContainer)),
                                const SizedBox(width: 18),
                                Icon(Icons.pie_chart, color: primary, size: 20),
                                const SizedBox(width: 6),
                                Text('Total: RM${(record['totalDividend'] as double).toStringAsFixed(2)}', style: theme.textTheme.bodyMedium?.copyWith(color: onSecondaryContainer)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            // Timestamp
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Calculated: ${record['timestamp']}',
                                style: theme.textTheme.bodySmall?.copyWith(color: onSecondaryContainer.withAlpha((0.7 * 255).round())),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
