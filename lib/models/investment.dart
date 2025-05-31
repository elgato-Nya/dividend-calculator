class Investment {
  final double fund;
  final double rate; // annual percentage, e.g. 5.0 for 5%
  final int months;  // 1..12 only

  Investment({
    required this.fund,
    required this.rate,
    required this.months,
  });

  /// Monthly dividend amount
  double get monthlyDividend => (rate / 100 / 12) * fund;

  /// Total dividend for the period
  double get totalDividend => monthlyDividend * months;
}
