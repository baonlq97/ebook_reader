import 'package:ebook_reader/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class BookDetailTopBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function() onBackClick;
  final void Function() onShareClick;

  const BookDetailTopBar(
      {super.key, required this.onBackClick, required this.onShareClick});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: onBackClick,
        child: Container(
          margin: const EdgeInsets.only(left: 22.0),
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.25),
          ),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      leadingWidth: 50.0 + 22.0,
      title: const Text(
        'Book Detail',
        style: TextStyle(
          fontFamily: FontFamily.pacifico,
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      // TODO: will do later
      // actions: [
      //   GestureDetector(
      //     onTap: () {},
      //     child: Container(
      //       margin: const EdgeInsets.only(right: 16.0),
      //       width: 50.0,
      //       height: 50.0,
      //       decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         color: Theme.of(context).colorScheme.onSurface.withOpacity(0.25),
      //       ),
      //       child: const Icon(Icons.share),
      //     ),
      //   ),
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 2);
}
