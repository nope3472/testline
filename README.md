# InternQuiz

InternQuiz is an interactive quiz application built with Flutter that offers an engaging learning experience. It features animated UI components, real-time progress tracking, and personalized feedback for users.

## Features

- **Interactive Quiz Interface**
  - Dynamic display of questions with animated option cards.
  - Real-time progress tracking using a liquid animation indicator.
  - Streak counter with visual feedback on user performance.
  - Confetti celebration animations to celebrate high scores.

- **Personalized Score Categories**
  - **Excellent**: 80% and above – Green
  - **Good Job**: 50-79% – Blue
  - **Keep Practicing**: 30-49% – Orange
  - **Needs Improvement**: Below 30% – Red

- **Detailed Results Screen**
  - Displays accuracy percentage and speed metrics.
  - Tracks the total number of tests completed and coins earned.
  - Offers a trophy system based on performance to motivate improvement.

## Technical Specifications

### Dependencies

The project relies on the following Flutter dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.4
  provider: ^6.0.5
  confetti: ^0.7.0
  flutter_svg: ^1.1.6
  cupertino_icons: ^1.0.8
PROJECT STRUCTURE
lib/
├── models/
│   └── quiz.dart          # Quiz data models
├── providers/
│   └── quiz_provider.dart # State management
├── screens/
│   ├── home_screen.dart   # Main menu
│   ├── quiz_screen.dart   # Quiz interface
│   └── result_screen.dart # Results display
├── services/
│   └── quiz_service.dart  # API integration
├── widgets/
│   ├── animation_option.dart    # Animated answer options
│   ├── liquid-indicator.dart    # Progress indicator
│   ├── progress_indicator.dart  # Question progress
│   └── score_category.dart      # Score visualization
└── main.dart                    # Application entry point
