import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationAppItem extends StatelessWidget {
  final String icon;
  final String label;
  const BottomNavigationAppItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: SvgPicture.asset(
        icon,
        width: 20,
        height: 20,
        color: Colors.black,
      ),
      label: label,
    );
  }
}