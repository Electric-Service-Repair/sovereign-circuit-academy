# QWEN.md — Context for AI Assistants

> **Project:** Vader Academy App  
> **Type:** Flutter Mobile Application  
> **Theme:** Star Wars / Darth Vader Electrical Training  
> **Location:** `/root/sovereign-circuit-academy/vader-academy-app`

---

## 📁 Project Overview

**Vader Academy App** is a Flutter-based mobile application for electrical training education, themed around Darth Vader and the dark side of the Force. The app teaches:

- **NEC Code Compliance** — National Electrical Code standards
- **Conduit Bending** — Precise bend calculations and techniques
- **Load Calculations** — Electrical load analysis
- **Quiz Training** — NEC knowledge assessments

The app follows **Clean Architecture** principles with a feature-first structure and uses **Riverpod** for state management.

---

## 🏗️ Architecture

### Directory Structure

```
vader-academy-app/
├── lib/
│   ├── core/                    # Shared core functionality
│   │   └── theme/
│   │       └── vader_colors.dart   # Dark theme color palette
│   └── features/
│       ├── conduit_bending/     # Conduit bending training module
│       │   ├── data/            # Data layer (models, repositories)
│       │   ├── presentation/    # UI screens, controllers
│       │   ├── providers/       # Riverpod providers
│       │   └── widgets/         # Feature-specific widgets
│       ├── home/                # Home/dashboard feature
│       │   └── providers/
│       │       └── home_provider.dart
│       ├── load_calculator/     # Electrical load calculator
│       │   ├── data/
│       │   ├── presentation/
│       │   ├── providers/
│       │   └── widgets/
│       ├── nec_quiz/            # NEC quiz/training module
│       │   ├── data/
│       │   ├── presentation/
│       │   ├── providers/
│       │   └── widgets/
│       └── shared/              # Shared across features
│           └── widgets/
│               ├── vader_button.dart
│               └── vader_card.dart
```

### State Management

Uses **Flutter Riverpod** with `StateNotifier` pattern:

```dart
// Example: HomeState + HomeNotifier
class HomeState { /* immutable state */ }
class HomeNotifier extends StateNotifier<HomeState> { /* state mutations */ }
final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>();
```

---

## 🎨 Design System

### Theme: Dark Side Aesthetic

| Color | Purpose |
|-------|---------|
| `VaderColors.redSith` | Primary accent, borders |
| `VaderColors.blackCarbon` | Card backgrounds |
| `VaderColors.blackVoid` | Deep backgrounds, text |
| `VaderColors.silverChrome` | Secondary text |
| `VaderColors.error` | Destructive actions, errors |
| `VaderColors.warning` | Warnings, cautions |

### UI Components

| Component | File | Description |
|-----------|------|-------------|
| `VaderButton` | `vader_button.dart` | Primary button with lightsaber gradient, 56dp height (glove-friendly) |
| `VaderIconButton` | `vader_button.dart` | Icon-only button, 48dp minimum |
| `VaderCard` | `vader_card.dart` | Container with shadow, border, Sith styling |
| `VaderInfoCard` | `vader_card.dart` | Information display with icon |
| `VaderStatCard` | `vader_card.dart` | Metrics and values display |
| `VaderListCard` | `vader_card.dart` | List item with consistent styling |

### Accessibility

- **Minimum touch targets:** 48x48dp (glove-friendly)
- **Font:** `StarJedi` for thematic consistency
- **Animations:** Scale effects on button press (100ms duration)

---

## 📦 Dependencies (Inferred)

Based on code analysis:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.x.x    # State management
  # Shared preferences (for progress persistence)
```

---

## 🛠️ Building and Running

> ⚠️ **Note:** No `pubspec.yaml` found in current directory structure. The project may be incomplete or files need to be created.

### Standard Flutter Commands

```bash
# Navigate to app directory
cd /root/sovereign-cademy/vader-academy-app

# Get dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Build APK
flutter build apk

# Run tests
flutter test
```

### TODO: Setup Required

1. Create `pubspec.yaml` with dependencies
2. Add `lib/core/theme/vader_colors.dart` (imported but missing)
3. Create main entry point (`main.dart`)
4. Add app scaffold and navigation

---

## 🧪 Development Practices

### Code Style

- **Darth Vader theming:** Comments include Vader quotes and heavy breathing emojis (🫁)
- **Documentation:** Dart doc comments on public APIs
- **Naming:** `State` + `Notifier` + `Provider` pattern for Riverpod
- **Error handling:** Try/catch with state error propagation

### Testing (Expected)

```dart
// Provider tests
test('HomeNotifier initializes with default state', () {
  final notifier = HomeNotifier();
  expect(notifier.state.completedModules, 0);
});
```

---

## 🤖 AI Agent Integration

This project uses specialized AI agents:

| Agent | Purpose |
|-------|---------|
| `darth-vader-coder` | Flutter code, dark theme, Riverpod, NEC compliance |
| `emperor-palpatine-guide` | Conduit app 5 pillars, Sith-themed enforcement |
| `yoda-conduit-mentor` | Conduit bending, NEC calculations |
| `chief-chirpa-reviewer` | Code review, security, safety |

---

## 📋 Current Status

| Feature | Status | Files Present |
|---------|--------|---------------|
| Home Module | 🟡 Partial | `home_provider.dart` only |
| Conduit Bending | 🔴 Empty | Directory structure only |
| Load Calculator | 🔴 Empty | Directory structure only |
| NEC Quiz | 🔴 Empty | Directory structure only |
| Shared Widgets | 🟢 Complete | `vader_button.dart`, `vader_card.dart` |
| Core Theme | 🔴 Missing | `vader_colors.dart` not found |

---

## 🚀 Next Steps

1. **Create `pubspec.yaml`** — Define dependencies and app metadata
2. **Implement `vader_colors.dart`** — Color constants for dark theme
3. **Add `main.dart`** — App entry point with Material theme
4. **Build home screen** — Dashboard with module selection
5. **Complete feature modules** — Conduit, Load, Quiz implementations
6. **Add persistence** — SharedPreferences for progress saving

---

*"The Force is strong with this project. Complete it, you must."*
