enum AppRoutes {
  intro,
  reminder,
  addReminder,
}

extension AppRoutesExtension on AppRoutes {
  String get routeName {
    switch (this) {
      case AppRoutes.intro:
        return '/';
      case AppRoutes.reminder:
        return '/reminder';
      case AppRoutes.addReminder:
        return '/add_reminder';
      default:
        return '/';
    }
  }
}
