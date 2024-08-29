import 'package:ebook_reader/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class LibraryCard extends StatelessWidget {
  final String title;
  final String author;
  final String fileSize;
  final String date;
  final bool isExternalBook;
  final VoidCallback onReadClick;
  final VoidCallback onDeleteClick;

  const LibraryCard({
    Key? key,
    required this.title,
    required this.author,
    required this.fileSize,
    required this.date,
    required this.isExternalBook,
    required this.onReadClick,
    required this.onDeleteClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withAlpha(40),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 72.0,
              width: 72.0,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isExternalBook
                    ? Icons
                        .import_contacts // Replace with your external book icon
                    : Icons.book, // Replace with your regular book icon
                size: 32.0,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: Assets.fonts.figeronaMedium),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    author,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: Assets.fonts.figeronaMedium),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 2.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        fileSize,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: Assets.fonts.figeronaMedium),
                      ),
                      const SizedBox(
                        height: 16.0, // Set a fixed height
                        child: VerticalDivider(
                          width: 12.0,
                          thickness: 1.0,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        date,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: Assets.fonts.figeronaMedium),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      LibraryCardButton(
                        text: 'Read',
                        icon: Icons.read_more,
                        onClick: onReadClick,
                      ),
                      const SizedBox(width: 10.0),
                      LibraryCardButton(
                        text: 'Delete',
                        icon: Icons.delete_outline,
                        onClick: onDeleteClick,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LibraryCardButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onClick;

  const LibraryCardButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: const WidgetStatePropertyAll(
          BorderSide(style: BorderStyle.solid),
        ),
        minimumSize: const WidgetStatePropertyAll(Size.zero),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
        padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0)),
        alignment: Alignment.center,
      ),
      onPressed: onClick,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14.0,
            color: Colors.black,
          ),
          const SizedBox(width: 2.0),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                fontFamily: Assets.fonts.figeronaMedium),
          ),
        ],
      ),
    );
  }
}
