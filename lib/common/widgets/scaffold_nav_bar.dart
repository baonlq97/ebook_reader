import 'package:ebook_reader/common/provider/bottom_navigation_app_bar/bottom_navigation_app_bar_provider.dart';
import 'package:ebook_reader/common/widgets/bottom_navigation_app_bar.dart' as app_bar;
import 'package:ebook_reader/presentations/pages/category/category_page.dart';
import 'package:ebook_reader/presentations/pages/home/home_page.dart';
import 'package:ebook_reader/presentations/pages/library/library_page.dart';
import 'package:ebook_reader/presentations/pages/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScaffoldWithNavBar extends ConsumerWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is a Navigator.
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationAppBarProvider);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const [
          HomePage(),
          CategoryPage(),
          LibraryPage(),
          SettingPage(),
        ],
      ),
      bottomNavigationBar: const app_bar.BottomNavigationAppBar(),
    );
  }
}