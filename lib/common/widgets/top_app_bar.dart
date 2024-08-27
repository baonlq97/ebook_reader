import 'package:ebook_reader/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String headerTitle;
  final String iconRes;
  final bool isShowTranslate;
  final void Function()? onSearchPressed;

  const TopAppBar({
    super.key,
    required this.headerTitle,
    required this.iconRes,
    this.isShowTranslate = false, // TODO: will do later,
    this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        headerTitle,
        style: const TextStyle(
          fontFamily: FontFamily.pacifico,
        ),
      ),
      actions: [
        if (isShowTranslate)
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.translate,
              color: Colors.black,
            ),
          ),
        IconButton(
          onPressed: onSearchPressed,
          icon: SvgPicture.asset(iconRes),
        ),
      ],
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(2),
        child: Divider(
          height: 2,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          indent: 16,
          endIndent: 16,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 2);
}
