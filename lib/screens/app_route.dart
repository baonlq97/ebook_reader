enum AppRoute {
  splash,
  home,
  categories,
  library,
  settings,
}

extension AppRoutePath on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.splash:
        return '/';
      case AppRoute.home:
        return '/home';
      case AppRoute.categories:
        return '/categories';
      case AppRoute.library:
        return '/library';
      case AppRoute.settings:
        return '/settings';
    }
  }
}