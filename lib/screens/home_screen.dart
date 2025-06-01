import 'package:flutter/material.dart';
import '../widgets/input_form.dart';
import '../widgets/result_card.dart';
import '../constants/app_styles.dart';

// Main HomeScreen widget for the dividend calculator
class HomeScreen extends StatefulWidget {
  // Optional callback for when a new calculation is made
  final void Function(double fund, double rate, int months, double monthlyDividend, double totalDividend)? onNewCalculation;
  const HomeScreen({super.key, this.onNewCalculation});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? _monthlyDividend;
  double? _totalDividend;

  // Called when calculation is performed in the InputForm
  void _onCalculate(double monthly, double total) {
    setState(() {
      _monthlyDividend = monthly;
      _totalDividend = total;
    });
    // Call the callback if provided
    if (widget.onNewCalculation != null) {
      if (_lastFund != null && _lastRate != null && _lastMonths != null) {
        widget.onNewCalculation!(_lastFund!, _lastRate!, _lastMonths!, monthly, total);
      }
    }
  }

  // Store last entered values for callback
  double? _lastFund;
  double? _lastRate;
  int? _lastMonths;

  // Called when form values change
  void _onFormChanged(double fund, double rate, int months) {
    _lastFund = fund;
    _lastRate = rate;
    _lastMonths = months;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;
    final surface = theme.colorScheme.surface;
    final onPrimary = theme.colorScheme.onPrimary;
    final primaryContainer = theme.colorScheme.primaryContainer;
    final onPrimaryContainer = theme.colorScheme.onPrimaryContainer;
    final secondaryContainer = theme.colorScheme.secondaryContainer;
    final onSecondaryContainer = theme.colorScheme.onSecondaryContainer;

    return Scaffold(
      backgroundColor: surface,
      appBar: AppBar(
        title: const Text('Unit Trust Dividend'),
        centerTitle: true,
        backgroundColor: primary,
        elevation: 0,
        foregroundColor: onPrimary,
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
                // Card containing the input form and formula preview
                _ModernCard(
                  color: surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Calculate Dividend',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: primary,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Tooltip(
                            message: 'Monthly Dividend = (Rate / 12) × Fund\nTotal Dividend = Monthly × Months',
                            child: Icon(Icons.info_outline, color: secondary, size: 22),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Shows the formula and example
                      _FormulaPreviewCard(),
                      const SizedBox(height: AppStyles.padding),
                      // User input form
                      InputForm(onCalculate: _onCalculate, onFormChanged: _onFormChanged),
                      const SizedBox(height: 8),
                      // Disclaimer row
                      Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, color: secondary.withAlpha((0.7 * 255).toInt()), size: 18),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Calculations are approximate. Actual dividends may vary due to fees, rounding, and market conditions.',
                              style: theme.textTheme.bodySmall?.copyWith(color: secondary.withAlpha((0.8 * 255).toInt())),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Show results if calculation has been made
                if (_monthlyDividend != null && _totalDividend != null) ...[
                  _ModernCard(
                    color: primaryContainer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.stacked_line_chart, color: secondary, size: 28),
                            const SizedBox(width: 10),
                            Text('Your Results', style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: onPrimaryContainer,
                            )),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Result display card
                        ResultCard(
                          monthlyDividend: _monthlyDividend!,
                          totalDividend: _totalDividend!,
                        ),
                      ],
                    ),
                  ),
                ],
                // Show prompt if no calculation yet
                if (_monthlyDividend == null) ...[
                  _ModernCard(
                    color: secondaryContainer,
                    child: Column(
                      children: [
                        Icon(Icons.touch_app, size: 80, color: primary.withAlpha((0.18 * 255).toInt())),
                        const SizedBox(height: AppStyles.padding),
                        Text(
                          'Enter your details and tap Calculate',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                          color: onSecondaryContainer.withAlpha((0.7 * 255).toInt()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom card widget with rounded corners and shadow
class _ModernCard extends StatelessWidget {
  final Widget child;
  final Color? color;

  const _ModernCard({
    required this.child,
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
      shadowColor: theme.colorScheme.shadow.withAlpha((0.04 * 255).toInt()),
      child: Padding(
        padding: const EdgeInsets.all(AppStyles.padding),
        child: child,
      ),
    );
  }
}

// Widget to preview the calculation formula and an example
class _FormulaPreviewCard extends StatefulWidget {
  @override
  State<_FormulaPreviewCard> createState() => _FormulaPreviewCardState();
}

class _FormulaPreviewCardState extends State<_FormulaPreviewCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryContainer = theme.colorScheme.secondaryContainer;
    final onSecondaryContainer = theme.colorScheme.onSecondaryContainer;
    // Example values for the formula preview
    final sampleFund = 10000;
    final sampleRate = 6.0;
    final sampleMonths = 6;
    final monthly = (sampleRate / 100 / 12) * sampleFund;
    final total = monthly * sampleMonths;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            leading: Icon(Icons.functions, color: onSecondaryContainer),
            title: Text('Formula Preview', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: onSecondaryContainer)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more, color: onSecondaryContainer),
              onPressed: () => setState(() => _expanded = !_expanded),
              tooltip: _expanded ? 'Hide formula' : 'Show formula',
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Formula explanation
                  Text(
                    'Monthly Dividend = (Rate ÷ 12) × Fund',
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, color: onSecondaryContainer),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Total Dividend = Monthly × Months',
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, color: onSecondaryContainer),
                  ),
                  const SizedBox(height: 12),
                  // Example calculation
                  Text('Example:', style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: onSecondaryContainer)),
                  const SizedBox(height: 2),
                  Text(
                    'Fund = RM$sampleFund\nRate = $sampleRate%\nMonths = $sampleMonths',
                    style: theme.textTheme.bodySmall?.copyWith(color: onSecondaryContainer.withAlpha((0.85 * 255).toInt())),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Monthly = ($sampleRate ÷ 12) × $sampleFund / 100 = RM${monthly.toStringAsFixed(2)}',
                    style: theme.textTheme.bodySmall?.copyWith(color: onSecondaryContainer),
                  ),
                  Text(
                    'Total = ${monthly.toStringAsFixed(2)} × $sampleMonths = RM${total.toStringAsFixed(2)}',
                    style: theme.textTheme.bodySmall?.copyWith(color: onSecondaryContainer),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
