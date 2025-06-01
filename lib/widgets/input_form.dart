import 'package:flutter/material.dart';
import '../models/investment.dart';
import '../utils/validators.dart';
import '../constants/app_styles.dart';

typedef CalculateCallback = void Function(
  double monthlyDividend,
  double totalDividend,
);

class InputForm extends StatefulWidget {
  final CalculateCallback onCalculate;
  final void Function(double fund, double rate, int months)? onFormChanged;

  const InputForm({super.key, required this.onCalculate, this.onFormChanged});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  final _fundCtrl = TextEditingController();
  final _rateCtrl = TextEditingController();
  final _monthsCtrl = TextEditingController();

  @override
  void dispose() {
    _fundCtrl.dispose();
    _rateCtrl.dispose();
    _monthsCtrl.dispose();
    super.dispose();
  }

  // Validate and submit the form, then call the callback with calculated dividends
  void _submit() {
    if (_formKey.currentState!.validate()) {
      final fund = double.parse(_fundCtrl.text);
      final rate = double.parse(_rateCtrl.text);
      final months = int.parse(_monthsCtrl.text);
      final inv = Investment(fund: fund, rate: rate, months: months);
      widget.onCalculate(inv.monthlyDividend, inv.totalDividend);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final onPrimary = theme.colorScheme.onPrimary;
    final secondary = theme.colorScheme.secondary;
    final surface = theme.colorScheme.surface;
    final onSurface = theme.colorScheme.onSurface;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Enter Investment Details',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: onSurface,
            ),
          ),
          const SizedBox(height: AppStyles.padding),

          TextFormField(
            controller: _fundCtrl,
            onChanged: (_) => _notifyFormChanged(),
            decoration: InputDecoration(
              labelText: 'Invested Fund (RM)',
              prefixIcon: Icon(Icons.attach_money, color: secondary),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: surface),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primary, width: 2),
              ),
              labelStyle: TextStyle(color: onSurface.withAlpha((0.7 * 255).toInt())),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: validateFund,
            style: TextStyle(color: onSurface),
          ),
          const SizedBox(height: AppStyles.padding),

          TextFormField(
            controller: _rateCtrl,
            onChanged: (_) => _notifyFormChanged(),
            decoration: InputDecoration(
              labelText: 'Annual Rate (%)',
              prefixIcon: Icon(Icons.percent, color: secondary),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: surface),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primary, width: 2),
              ),
              labelStyle: TextStyle(color: onSurface.withAlpha((0.7 * 255).toInt())),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: validateRate,
            style: TextStyle(color: onSurface),
          ),
          const SizedBox(height: AppStyles.padding),

          TextFormField(
            controller: _monthsCtrl,
            onChanged: (_) => _notifyFormChanged(),
            decoration: InputDecoration(
              labelText: 'Months Invested (1–12)',
              prefixIcon: Icon(Icons.calendar_today, color: secondary),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: surface),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primary, width: 2),
              ),
              labelStyle: TextStyle(color: onSurface.withAlpha((0.7 * 255).toInt())),
            ),
            keyboardType: TextInputType.number,
            validator: validateMonths,
            style: TextStyle(color: onSurface),
          ),
          const SizedBox(height: AppStyles.padding * 1.5),

          // Button to trigger calculation
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 2,
                shadowColor: primary.withAlpha((0.10 * 255).toInt()),
              ),
              child: const Text('Calculate Dividend'),
            ),
          ),
        ],
      ),
    );
  }

  // Notify parent widget when form fields change
  void _notifyFormChanged() {
    if (widget.onFormChanged != null) {
      final fund = double.tryParse(_fundCtrl.text) ?? 0;
      final rate = double.tryParse(_rateCtrl.text) ?? 0;
      final months = int.tryParse(_monthsCtrl.text) ?? 0;
      widget.onFormChanged!(fund, rate, months);
    }
  }
}
