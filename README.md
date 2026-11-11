# Telegram Clone (Flutter)

A mobile Telegram clone built with Flutter & Dart for educational purposes. The goal of this project is to master Flutter UI development, Clean Architecture (feature-first), state management, and real-time backend integration step by step.

---

## 🚀 How to Run

### Prerequisites
- Flutter SDK (>= 3.47.0)
- Dart SDK (>= 3.13.0)

### Run the App
```bash
# 1. Fetch dependencies
flutter pub get

# 2. Analyze code for any issues
flutter analyze

# 3. Run unit & widget tests
flutter test

# 4. Launch the application
flutter run
# Or specifically for Linux desktop:
flutter run -d linux
```

---

## 📁 Project Structure (Feature-First)

The project follows a **feature-first** architecture to ensure modularity, high maintainability, and clean separation of concerns:

```text
lib/
├── core/                         # Shared utilities, constants, and themes
│   ├── constants/
│   │   └── app_constants.dart    # Telegram-like color palette & dimensions
│   ├── theme/
│   │   └── app_theme.dart        # Material 3 light & dark theme definitions
│   └── utils/
│       └── date_utils.dart       # Chat time/date formatting helpers
├── features/                     # Functional modules
│   ├── auth/                     # Authentication & onboarding
│   │   ├── data/                 # Auth data sources & repositories (future)
│   │   ├── models/               # User model
│   │   └── presentation/         # SplashPage, LoginPage
│   ├── chats/                    # Chats list & dialog overview
│   │   ├── data/                 # Mock chat dialogs & mock user
│   │   ├── models/               # Chat model
│   │   └── presentation/         # ChatsPage
│   ├── messages/                 # Single chat room & messages
│   │   ├── data/                 # Mock messages list
│   │   ├── models/               # Message model & MessageStatus enum
│   │   └── presentation/         # ChatPage
│   ├── profile/                  # User profile & avatar
│   │   ├── data/
│   │   ├── models/
│   │   └── presentation/         # ProfilePage
│   └── settings/                 # App settings & theme switcher
│       ├── data/
│       ├── models/
│       └── presentation/         # SettingsPage
└── main.dart                     # Application entry point (TelegramApp)
```

---

## 🗺️ Project Roadmap & Checklist

- [x] **Stage 0: Foundation & Setup**
  - [x] Flutter project initialization with clean configuration
  - [x] Feature-first directory structure
  - [x] Material 3 Light and Dark themes (Telegram blue palette)
  - [x] Handcrafted immutable data models (`User`, `Chat`, `Message`)
  - [x] Realistic mock data for chats and messages
  - [x] Placeholder pages with Scaffold & AppBar
  - [x] Smoke tests and date formatting tests
  - [x] Full technical specification and progress documentation
- [ ] **Stage 1: UI with Mock Data**
  - [ ] Implement `ChatsPage` with `ListView.builder` and custom `ChatTile`
  - [ ] Implement `ChatPage` with custom message bubbles and input bar
  - [ ] Connect navigation between `ChatsPage` and `ChatPage`
  - [ ] Implement `ProfilePage` and `SettingsPage`
  - [ ] Implement search filter for chats
- [ ] **Stage 2: State Management**
  - [ ] Introduce state management (`flutter_bloc` or `Riverpod`)
  - [ ] Manage active chats and send/receive messages in state
  - [ ] Manage theme switching (Light / Dark)
- [ ] **Stage 3: Local Storage**
  - [ ] Cache chats and messages locally using Hive or Drift (SQLite)
  - [ ] Offline message viewing and draft saving
- [ ] **Stage 4: Real Backend (Firebase)**
  - [ ] Phone / Email Authentication with Firebase Auth
  - [ ] Cloud Firestore for real-time messages and chat sync
  - [ ] Firebase Storage for avatar and image sharing
  - [ ] Firebase Cloud Messaging (FCM) for push notifications
- [ ] **Stage 5: Finishing & Polish**
  - [ ] Error handling & empty states
  - [ ] Responsive layouts & edge cases
  - [ ] Release preparation & documentation
