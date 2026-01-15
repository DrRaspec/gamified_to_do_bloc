# Contributing to Gamified To-Do App

First off, thank you for considering contributing to Gamified To-Do App! 🎉

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples**
- **Describe the behavior you observed and what you expected**
- **Include screenshots if relevant**
- **Include your environment details** (OS, Flutter version, device)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

- **A clear and descriptive title**
- **A detailed description of the proposed feature**
- **Explain why this enhancement would be useful**
- **List any alternatives you've considered**

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Follow the project structure** and coding conventions
3. **Write clear commit messages** following the format:

   ```
   feat: Add new task filter feature
   fix: Resolve login authentication bug
   docs: Update README with new instructions
   style: Format code according to guidelines
   refactor: Restructure auth bloc logic
   test: Add unit tests for task repository
   chore: Update dependencies
   ```

4. **Ensure your code follows the style guide**:

   - Run `flutter analyze` to check for issues
   - Run `dart format .` to format code
   - Follow Dart/Flutter best practices

5. **Test your changes**:

   - Test on both Android and iOS if possible
   - Ensure no existing functionality is broken
   - Add tests for new features

6. **Update documentation** if needed
7. **Submit your pull request** with a clear description

## Development Setup

1. Clone your fork:

   ```bash
   git clone https://github.com/YOUR-USERNAME/gamified_to_do_bloc.git
   ```

2. Create a branch:

   ```bash
   git checkout -b feature/my-new-feature
   ```

3. Make your changes and commit:

   ```bash
   git add .
   git commit -m "feat: Add my new feature"
   ```

4. Push to your fork:

   ```bash
   git push origin feature/my-new-feature
   ```

5. Open a Pull Request

## Coding Conventions

### Dart/Flutter Style

- Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter_lints` for linting
- Prefer `const` constructors where possible
- Use meaningful variable and function names

### BLoC Pattern

- Keep business logic in BLoCs, not in UI
- Use sealed classes for events and states
- Emit states based on use cases, not UI requirements
- Use Equatable for value comparison

### File Naming

- Use lowercase with underscores: `my_file.dart`
- Match file names with main class names
- Group related files in feature folders

### Comments

- Write self-documenting code
- Add comments for complex logic
- Use `///` for documentation comments
- Document public APIs

## Project Structure

Follow the existing architecture:

```
lib/
├── app/           # App configuration
├── core/          # Shared utilities
├── features/      # Feature modules (BLoC pattern)
├── models/        # Data models
└── repository/    # Data access layer
```

## Testing

- Write unit tests for business logic
- Write widget tests for UI components
- Ensure test coverage for new features
- Run tests before submitting PR:
  ```bash
  flutter test
  ```

## Questions?

Feel free to open an issue with your question or reach out to the maintainers.

Thank you for contributing! 🚀
