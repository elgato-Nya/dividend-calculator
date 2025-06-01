# Unit Trust Dividend Calculator

A modern, user-friendly Flutter app for calculating estimated dividends from unit trust investments. This tool helps investors quickly estimate their monthly and total dividends based on their invested fund, annual rate, and investment duration.

## Features

- **Intuitive Input Form:** Enter your invested fund, annual dividend rate, and investment period (in months).
- **Instant Results:** View calculated monthly and total dividends with a clear, attractive summary card.
- **Calculation History:** Review your recent calculations, including all input parameters and results, with timestamps.
- **Formula Transparency:** Expandable formula preview card explains the calculation logic and provides worked examples.
- **Responsive UI:** Clean, modern design with adaptive theming for a pleasant experience on all devices.
- **Validation & Guidance:** Input validation and helpful tooltips ensure accurate and meaningful results.

## Calculation Logic

- **Monthly Dividend:**  
  `(Annual Rate ÷ 12) × Fund / 100`
- **Total Dividend:**  
  `Monthly Dividend × Months Invested`

*Note: Calculations are approximate. Actual dividends may vary due to fees, rounding, and market conditions.*

## Getting Started

1. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd dividend-calculator
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **Run the app:**
   ```sh
   flutter run
   ```

## Project Structure

- `lib/screens/` – Main app screens (`home_screen.dart`, `history_screen.dart`, etc.)
- `lib/widgets/` – Reusable UI components (`input_form.dart`, `result_card.dart`)
- `lib/models/` – Data models (e.g., `investment.dart`)
- `lib/utils/` – Utility functions and validators
- `lib/constants/` – App-wide style constants

## Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements, bug fixes, or new features.

## License

This project is licensed under the MIT License.

---

For more information on Flutter, see the [official documentation](https://docs.flutter.dev/).
