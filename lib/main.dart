import 'package:ebook_reader/common/widgets/scaffold_nav_bar.dart';
import 'package:ebook_reader/screens/app_route.dart';
import 'package:ebook_reader/screens/category/presentation/ui/category_page.dart';
import 'package:ebook_reader/screens/home/presentation/ui/home_page.dart';
import 'package:ebook_reader/screens/library/presentation/ui/library_page.dart';
import 'package:ebook_reader/screens/setting/presentation/ui/setting_page.dart';
import 'package:ebook_reader/screens/splash/presentation/ui/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

void main() {
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
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ebook Reader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
