import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_navigation_app_bar_notifier.g.dart';

@riverpod
class BottomNavigationAppBar extends _$BottomNavigationAppBar {
  @override
  int build() {
    return 0;
  }

  void changePage(int page) {
    state = page;
  }
}