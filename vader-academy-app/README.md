# Vader Academy App

*heavy breathing* 🫁 Welcome to the Imperial Training Application.

## Overview

The Vader Academy App is a comprehensive Flutter mobile training application for electrical workers. Master NEC codes, conduit bending, and load calculations with the dark side of perfect precision.

**The Code is strong with this one.** ✨

---

## Features

### 🎯 Core Training Modules

1. **NEC Codes** - Master the National Electrical Code 2026
   - Article-by-article lessons
   - Interactive quizzes
   - Quick reference tables
   - Compliance tracking

2. **Conduit Bending** - Perfect your bend calculations
   - 90° Stub-Up bends
   - Offset bends
   - Saddle bends (3-point and 4-point)
   - Bend deduction calculator
   - Conduit size selector

3. **Load Calculator** - Calculate electrical loads with precision
   - Residential load calculations (NEC Article 220)
   - Commercial load calculations
   - Service size determination
   - Wire ampacity reference

### 🎨 Design Features

- **Dark Theme** - Black and red Sith color scheme
- **Glove-Friendly UI** - Minimum 48x48dp touch targets
- **Imperial Typography** - Orbitron and StarJedi fonts
- **Lightsaber Effects** - Glowing progress bars and accents

### 📱 Technical Features

- **State Management** - Riverpod StateNotifier pattern
- **Clean Architecture** - Feature-first organization
- **Null Safety** - Full Dart null safety support
- **Error Handling** - Comprehensive error boundaries

---

## Project Structure

```
vader-academy-app/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   └── app_constants.dart
│   │   ├── theme/
│   │   │   ├── vader_colors.dart
│   │   │   └── vader_theme.dart
│   │   └── widgets/
│   │       ├── vader_button.dart
│   │       ├── vader_card.dart
│   │       ├── vader_stat_card.dart
│   │       └── index.dart
│   ├── features/
│   │   ├── home/
│   │   │   ├── presentation/
│   │   │   │   └── home_screen.dart
│   │   │   └── providers/
│   │   │       └── home_provider.dart
│   │   ├── nec_codes/
│   │   │   ├── presentation/
│   │   │   │   └── nec_screen.dart
│   │   │   ├── providers/
│   │   │   └── data/
│   │   ├── conduit_bending/
│   │   │   ├── presentation/
│   │   │   │   └── conduit_screen.dart
│   │   │   ├── providers/
│   │   │   └── data/
│   │   └── load_calculator/
│   │       ├── presentation/
│   │       │   └── load_screen.dart
│   │       ├── providers/
│   │       └── data/
│   └── main.dart
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

---

## Setup Instructions

### Prerequisites

- Flutter SDK 3.10.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code with Flutter extensions
- Xcode (for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd vader-academy-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Build for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

---

## Architecture

### Clean Architecture Principles

- **Separation of Concerns** - Each feature is self-contained
- **Dependency Rule** - Dependencies point inward
- **Testability** - Business logic is framework-agnostic

### State Management (Riverpod)

```dart
final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(),
);

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);
    // ...
  }
}
```

### Theme System

The app uses a custom dark theme with Sith-inspired colors:

- **Primary**: Red Sith (#D32F2F)
- **Background**: Black Void (#000000)
- **Surface**: Black Carbon (#0A0A0A)
- **Accent**: Gold (#FFD700)

---

## Quality Standards

### NEC Compliance Mindset
All calculations follow NEC 2026 standards. There are no shortcuts.

### Safety First
Proper error handling everywhere. The dark side tolerates no crashes.

### Glove-Friendly Design
Minimum 48dp touch targets for workers wearing protective gloves.

### Code Quality
- Strict lint rules enabled
- No implicit dynamic types
- Const constructors where possible
- Proper disposal of controllers

---

## Feature Roadmap

### Phase 1 (Current) ✅
- [x] Core theme and widgets
- [x] Home screen dashboard
- [x] NEC Codes module (basic)
- [x] Conduit Bending calculator
- [x] Load Calculator (residential)

### Phase 2 (In Progress)
- [ ] Full NEC quiz implementation
- [ ] Commercial load calculations
- [ ] User authentication
- [ ] Progress synchronization

### Phase 3 (Planned)
- [ ] Voice command integration
- [ ] AR conduit bending guide
- [ ] Multi-language support
- [ ] Offline mode

---

## Vader Quotes

> "I find your lack of precision... disturbing."

> "The Code is strong with this one."

> "Join the dark side of perfect bends."

> "You underestimate the power of the NEC."

> "The dark side of perfect bends awaits."

---

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

**Remember:** The dark side does not tolerate sloppy code. Ensure your contributions meet all quality standards.

---

## License

This project is proprietary software of the Vader Academy Empire.
Unauthorized distribution is forbidden.

---

## Contact

*heavy breathing* 🫁

For questions or support, contact the Imperial Training Division.

**May the Force be with you.** ⚡
