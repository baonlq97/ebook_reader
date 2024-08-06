import 'package:ebook_reader/common/notifier/bottom_navigation_app_bar_notifier.dart';
import 'package:ebook_reader/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationAppBar extends ConsumerWidget {
  const BottomNavigationAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = ref.watch(bottomNavigationAppBarProvider);
    // int selectedIndex = 0;
    return NavigationBar(
      selectedIndex: selectedIndex,
      destinations: [
        NavigationDestination(
          icon: SvgPicture.asset(
            Assets.drawable.icNavHome,
            width: 20,
            height: 20,
            color: Colors.black,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            Assets.drawable.icNavCategories,
            width: 20,
            height: 20,
            color: Colors.black,
          ),
          label: 'Categories',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            Assets.drawable.icNavLibrary,
            width: 20,
            height: 20,
            color: Colors.black,
          ),
          label: 'Library',
        ),
        NavigationDestination(
          icon: SvgPicture.asset(
            Assets.drawable.icNavSettings,
            width: 20,
            height: 20,
            color: Colors.black,
          ),
          label: 'Settings',
        ),
      ],
      onDestinationSelected: (index) {
        ref.read(bottomNavigationAppBarProvider.notifier).changePage(index);
      },
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      indicatorColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
    );
  }
}
