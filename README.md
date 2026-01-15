# 🎮 Gamified To-Do App

A gamified task management application built with Flutter and BLoC pattern. Level up your productivity by completing tasks and tracking your progress!

## ✨ Features

- 🔐 **Authentication** - Secure login and registration with JWT tokens
- ✅ **Task Management** - Create, update, and complete tasks
- 📅 **Calendar View** - Visualize tasks on a calendar
- 👤 **User Profile** - Manage your account and preferences
- 🎯 **Gamification** - Earn points and level up by completing tasks
- 🌙 **Dark Theme** - Beautiful dark UI with bright green accents
- 📱 **Cross-Platform** - Runs on Android, iOS, Web, Windows, macOS, and Linux

## 🏗️ Architecture

This project follows **Clean Architecture** principles with the **BLoC (Business Logic Component)** pattern for state management.

### Project Structure

```
lib/
├── app/                    # App-level configuration
│   ├── di/                # Dependency injection
│   └── router/            # Navigation routing
├── core/                  # Core functionality
│   ├── constants/         # App constants
│   ├── errors/           # Error handling
│   ├── network/          # API client setup
│   ├── storage/          # Local storage
│   ├── theme/            # App theming
│   ├── utils/            # Utility functions
│   └── widgets/          # Reusable widgets
├── features/             # Feature modules
│   ├── auth/            # Authentication
│   ├── tasks/           # Task management
│   ├── calendar/        # Calendar view
│   ├── profile/         # User profile
│   └── main/            # Main shell/navigation
├── models/              # Data models
└── repository/          # Data repositories
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: `>=3.10.0`
- Dart SDK: `^3.10.0`
- iOS development: Xcode (macOS only)
- Android development: Android Studio

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/DrRaspec/gamified_to_do_bloc.git
   cd gamified_to_do_bloc
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Set up environment variables**

   Create your environment files based on the example:

   ```bash
   cp env/.env.example env/.env.dev
   cp env/.env.example env/.env.prod
   ```

   Then edit `env/.env.dev` and `env/.env.prod` with your API configuration:

   ```
   API_BASE_URL=https://your-api-url.com
   API_TIMEOUT=30000
   ```

4. **Run code generation** (if needed)

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**

   ```bash
   # Development
   flutter run --dart-define-from-file=env/.env.dev

   # Production
   flutter run --dart-define-from-file=env/.env.prod
   ```

## 📱 Platform-Specific Setup

### Android

No additional setup required. The project is configured to run on Android API 21+.

### iOS

1. Navigate to the iOS directory:

   ```bash
   cd ios
   ```

2. Install CocoaPods dependencies:

   ```bash
   pod install
   ```

3. Open `Runner.xcworkspace` in Xcode and configure signing.

### Web

Run with:

```bash
flutter run -d chrome
```

## 🛠️ Tech Stack

### Core

- **Flutter** - UI framework
- **Dart** - Programming language

### State Management

- **flutter_bloc** (^8.1.6) - BLoC pattern implementation
- **bloc** (^8.1.4) - Core BLoC library
- **equatable** (^2.0.7) - Value equality

### Navigation

- **go_router** (^14.6.0) - Declarative routing

### Networking

- **dio** (^5.9.0) - HTTP client
- **pretty_dio_logger** (^1.4.0) - API logging

### Storage

- **flutter_secure_storage** (^10.0.0) - Secure token storage

### Dependency Injection

- **get_it** (^8.0.2) - Service locator

### Development

- **build_runner** - Code generation
- **flutter_lints** - Linting rules

## 🔑 Environment Variables

The app uses environment-based configuration. Never commit your `.env` files!

**Required variables:**

- `API_BASE_URL` - Your backend API URL
- `API_TIMEOUT` - Request timeout in milliseconds

## 📝 API Endpoints

The app expects the following API endpoints:

- `POST /v1/auth/login` - User login
- `POST /v1/auth/register` - User registration
- `POST /v1/auth/refresh` - Refresh access token
- `GET /v1/user/me` - Get current user
- Additional task management endpoints (see API documentation)

## 🎨 Theme & Design

The app features a beautiful dark theme with:

- **Primary Color**: Bright Green (`#00E676`)
- **Background**: Dark (`#121212`)
- **Surface**: Dark Grey (`#1E1E1E`)
- Custom widgets for consistent UI/UX

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Authors

DrRaspec - [@DrRaspec](https://github.com/DrRaspec)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- BLoC library maintainers
- All contributors to the open-source packages used

## 📞 Support

For support, open an issue in the [GitHub repository](https://github.com/DrRaspec/gamified_to_do_bloc/issues).

---

**Note:** This is a work in progress. More features are coming soon! ⚡
