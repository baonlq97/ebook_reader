import 'package:ebook_reader/common/config/theme_data.dart';
import 'package:ebook_reader/common/widgets/scaffold_nav_bar.dart';
import 'package:ebook_reader/common/widgets/transition_factory.dart';
import 'package:ebook_reader/presentations/app_route.dart';
import 'package:ebook_reader/presentations/pages/book_detail/book_detail.dart';
import 'package:ebook_reader/presentations/pages/book_reader/book_reader.dart';
import 'package:ebook_reader/presentations/pages/category/category_page.dart';
import 'package:ebook_reader/presentations/pages/home/home_page.dart';
import 'package:ebook_reader/presentations/pages/library/library_page.dart';
import 'package:ebook_reader/presentations/pages/setting/setting_page.dart';
import 'package:ebook_reader/presentations/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Isar.initializeIsarCore();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoute.splash.path,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoute.splash.path,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRoute.home.path,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: HomePage());
            },
          ),
          GoRoute(
            path: AppRoute.categories.path,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: CategoryPage());
            },
          ),

          /// The third screen to display in the bottom navigation bar.
          GoRoute(
            path: AppRoute.library.path,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: LibraryPage());
            },
          ),
          GoRoute(
            path: AppRoute.settings.path,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return const NoTransitionPage(child: SettingPage());
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoute.bookDetail.path,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final bookId = extra['bookId'];
          final bookDetailPage = BookDetailPage(
            bookId: bookId,
          );
          return CustomTransitionPage(
            child: bookDetailPage,
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: AppRoute.bookReader.path,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          final extra = state.extra as Map<String, dynamic>;
          final libraryItem = extra['libraryItem'];
          return BookReaderPage(
            libraryItem: libraryItem,
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ebook Reader',
      theme: lightTheme,
      routerConfig: _router,
    );
  }
}
