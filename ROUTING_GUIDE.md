# Routing & Navigation Guide

## Overview

The app now has a complete routing system with authentication middleware using **go_router**. When users are not logged in, they're automatically redirected to the login page. When logged in, they can access the main app.

## Features Implemented

### 1. **Authentication Middleware (Route Guards)**
- ✅ Automatically redirects to login if not authenticated
- ✅ Automatically redirects to home if already authenticated (can't access login)
- ✅ Splash screen while checking authentication status
- ✅ Refreshes routes when auth state changes

### 2. **Dark Green Theme**
- ✅ Dark background (#121212)
- ✅ Bright green primary color (#00E676)
- ✅ Dark green secondary color (#00C853)
- ✅ Material Design 3
- ✅ Consistent styling across all components

### 3. **Main Shell Navigation**
- ✅ Bottom navigation bar with 4 tabs:
  - Home
  - Tasks
  - Calendar
  - Profile
- ✅ Automatically syncs with current route
- ✅ Smooth navigation between sections

## Route Structure

```
/splash          → Splash screen (auth check)
/login           → Login page (public)
/home            → Home page (protected)
/tasks           → Tasks page (protected)
/calendar        → Calendar page (protected)
/profile         → Profile page (protected, includes logout)
```

## How It Works

### Authentication Flow

1. **App Starts** → Shows splash screen
2. **AuthBloc checks token** → 
   - If token exists → Navigate to `/home`
   - If no token → Navigate to `/login`
3. **User logs in** → Token saved → Auto navigate to `/home`
4. **User logs out** → Token cleared → Auto navigate to `/login`

### Code Example: Route Guard Logic

```dart
redirect: (context, state) async {
  final authState = context.read<AuthBloc>().state;
  
  // If authenticated, don't allow login page
  if (authState is Authenticated && isGoingToLogin) {
    return '/home';
  }
  
  // If not authenticated, redirect to login
  if (authState is Unauthenticated && !isGoingToLogin) {
    return '/login';
  }
  
  return null; // No redirect needed
}
```

## Files Created/Modified

### New Files:
1. `lib/core/theme/app_theme.dart` - Dark green theme
2. `lib/app/router/app_router.dart` - Router with guards
3. `lib/features/auth/view/login_page.dart` - Login UI
4. `lib/features/main/view/main_shell.dart` - Bottom navigation

### Modified Files:
1. `lib/app/app.dart` - Now uses router and theme
2. `lib/app/di/service_locator.dart` - Added AuthBloc registration

## Theme Colors

```dart
Primary Green:   #00E676 (Bright green for buttons, highlights)
Dark Green:      #00C853 (Secondary actions)
Background:      #121212 (Main background)
Surface:         #1E1E1E (Cards, app bar)
Error:           #CF6679 (Error messages)
```

## Usage Examples

### Navigate Between Pages

```dart
// In any widget
context.go('/tasks');      // Navigate to tasks
context.go('/profile');    // Navigate to profile
```

### Check Authentication Status

```dart
// Listen to auth state
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is Authenticated) {
      // User logged in
    } else if (state is Unauthenticated) {
      // User logged out
    }
  },
  child: MyWidget(),
)
```

### Logout User

```dart
// Trigger logout
context.read<AuthBloc>().add(LoggedOut());

// This will:
// 1. Clear tokens
// 2. Change auth state to Unauthenticated
// 3. Router automatically redirects to /login
```

## Next Steps

### To Implement Login Logic:

1. **Update login_page.dart**:
```dart
void _handleLogin() {
  if (_formKey.currentState!.validate()) {
    context.read<AuthBloc>().add(
      LoginRequested(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
```

2. **Add LoginRequested event to AuthBloc**:
```dart
// In auth_event.dart
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  
  LoginRequested({required this.email, required this.password});
}

// In auth_bloc.dart
on<LoginRequested>(_onLogin);

Future<void> _onLogin(
  LoginRequested event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  try {
    final response = await authRepository.login(
      event.email,
      event.password,
    );
    
    final data = response.data;
    await tokenStorage.writeTokens(
      accessToken: data['accessToken'],
      refreshToken: data['refreshToken'],
    );
    
    emit(Authenticated());
  } on ApiException catch (e) {
    emit(AuthError(e.message));
  }
}
```

## Testing the Navigation

1. **Start app** → Should show splash then login
2. **Try to access /home** → Should redirect to login
3. **"Login" (for now just navigate)** → Should go to home
4. **Try to access /login while "logged in"** → Should redirect to home
5. **Click logout on profile** → Should go back to login

## Customization

### Change Theme Colors

Edit `lib/core/theme/app_theme.dart`:

```dart
static const Color primaryGreen = Color(0xFF00E676); // Change this
static const Color darkGreen = Color(0xFF00C853);    // And this
```

### Add New Routes

Edit `lib/app/router/app_router.dart`:

```dart
ShellRoute(
  builder: (context, state, child) => MainShell(child: child),
  routes: [
    // ... existing routes
    GoRoute(
      path: '/new-page',
      builder: (context, state) => const NewPage(),
    ),
  ],
),
```

## Benefits

✅ **Type-safe navigation** - No string route names scattered everywhere  
✅ **Automatic auth handling** - Middleware handles redirects  
✅ **Deep linking ready** - go_router supports URLs  
✅ **State-driven** - Routes respond to BLoC state changes  
✅ **Clean separation** - Auth logic stays in AuthBloc  
✅ **Modern theming** - Material Design 3 with dark mode  
✅ **Consistent UI** - Green accents throughout the app  

Your app now has professional routing and a great dark green theme! 🚀
