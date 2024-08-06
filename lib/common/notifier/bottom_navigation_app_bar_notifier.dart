import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_navigation_app_bar_notifier.g.dart';

// class CurrentTabNotifier extends ValueNotifier<int> {
//   CurrentTabNotifier() : super(0);

//   bool get isHomeTab => value == 0;
//   void changePage(int page) {
//     value = page;
//   }
// }

// final bottomNavigationAppBarProvider = ChangeNotifierProvider<CurrentTabNotifier>((ref) {
//   return CurrentTabNotifier();
// });

// @riverpod
// class BottomNavigationAppBar extends $BottomNavigationAppBar {
  

//   void changePage(int page) {
    
//   }
// }

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