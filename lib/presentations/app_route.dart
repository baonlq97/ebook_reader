enum AppRoute {
  splash,
  home,
  categories,
  library,
  settings,
  bookDetail,
  bookReader,
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
      case AppRoute.bookDetail:
        return '/book_detail/:bookId';
      case AppRoute.bookReader:
        return '/book_reader/:bookId';
    }
  }
}