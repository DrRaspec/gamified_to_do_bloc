import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppNotifications {
  static void showSuccess(
    BuildContext context, {
    required String message,
    String? title,
    Duration? duration,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      title: Text(title ?? 'Success'),
      description: Text(message),
      alignment: Alignment.topRight,
      autoCloseDuration: duration ?? const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle),
      primaryColor: const Color(0xFF00E676),
      backgroundColor: const Color(0xFF00E676),
      foregroundColor: Colors.black,
      borderRadius: BorderRadius.circular(12),
      boxShadow: highModeShadow,
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    String? title,
    Duration? duration,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      title: Text(title ?? 'Error'),
      description: Text(message),
      alignment: Alignment.topRight,
      autoCloseDuration: duration ?? const Duration(seconds: 4),
      icon: const Icon(Icons.error),
      primaryColor: Colors.red,
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: highModeShadow,
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    String? title,
    Duration? duration,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      title: Text(title ?? 'Info'),
      description: Text(message),
      alignment: Alignment.topRight,
      autoCloseDuration: duration ?? const Duration(seconds: 3),
      icon: const Icon(Icons.info),
      primaryColor: Colors.blue,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: highModeShadow,
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    String? title,
    Duration? duration,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.fillColored,
      title: Text(title ?? 'Warning'),
      description: Text(message),
      alignment: Alignment.topRight,
      autoCloseDuration: duration ?? const Duration(seconds: 3),
      icon: const Icon(Icons.warning),
      primaryColor: Colors.orange,
      backgroundColor: Colors.orange,
      foregroundColor: Colors.black,
      borderRadius: BorderRadius.circular(12),
      boxShadow: highModeShadow,
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
  }
}
