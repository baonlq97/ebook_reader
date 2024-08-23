import 'package:ebook_reader/presentations/app_route.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_navigation_app_bar_provider.g.dart';

enum BottomNavState {
  home,
  library
}

@riverpod
class BottomNavigationAppBar extends _$BottomNavigationAppBar {
  @override
  BottomNavState build() {
    return BottomNavState.home;
  }

  void changePage(BottomNavState navState) {
    state = navState;
  }
}