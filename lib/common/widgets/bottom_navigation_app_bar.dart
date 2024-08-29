// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ebook_reader/common/widgets/bottom_navigation_app_item.dart';
import 'package:ebook_reader/presentations/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ebook_reader/common/provider/bottom_navigation_app_bar/bottom_navigation_app_bar_provider.dart';
import 'package:ebook_reader/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationAppBar extends ConsumerWidget {
  const BottomNavigationAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BottomNavState selectedIndex = ref.watch(bottomNavigationAppBarProvider);
    return NavigationBar(
      selectedIndex: selectedIndex.index,
      destinations: [
        BottomNavigationAppItem(
          icon: Assets.drawable.icNavHome,
          label: 'Home',
        ),
        // Note: will add later
        // BottomNavigationAppItem(
        //   icon: Assets.drawable.icNavCategories,
        //   label: 'Categories',
        // ),
        BottomNavigationAppItem(
          icon: Assets.drawable.icNavLibrary,
          label: 'Library',
        ),
        // Note: will add later
        // BottomNavigationAppItem(
        //   icon: Assets.drawable.icNavSettings,
        //   label: 'Settings',
        // ),
      ],
      onDestinationSelected: (index) {
        ref.read(bottomNavigationAppBarProvider.notifier).changePage(BottomNavState.values[index]);
        _onItemTapped(index, context);
      },
      backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(40),
      indicatorColor: Theme.of(context).colorScheme.primary.withAlpha(50),
    );
  }



  // static int _calculateSelectedIndex(BuildContext context) {
  //   final String location = GoRouterState.of(context).uri.path;
  //   if (location.startsWith('/a')) {
  //     return 0;
  //   }
  //   if (location.startsWith('/b')) {
  //     return 1;
  //   }
  //   if (location.startsWith('/c')) {
  //     return 2;
  //   }
  //   return 0;
  // }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(AppRoute.home.path);
      // case 1:
      //   GoRouter.of(context).go(AppRoute.categories.path);
      case 1:
        GoRouter.of(context).go(AppRoute.library.path);
      // case 3:
      //   GoRouter.of(context).go(AppRoute.settings.path);
    }
  }
}