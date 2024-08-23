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
      color: Theme.of(context).colorScheme.primary.withAlpha(50),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 90.0,
              width: 90.0,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isExternalBook
                    ? Icons.import_contacts // Replace with your external book icon
                    : Icons.book, // Replace with your regular book icon
                size: 32.0,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    author,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 2.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        fileSize,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const VerticalDivider(
                        width: 12.0,
                        thickness: 1.0,
                      ),
                      Text(
                        date,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      LibraryCardButton(
                        text: 'Read',
                        icon: Icons.read_more, // Replace with your read icon
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
    return OutlinedButton.icon(
      onPressed: onClick,
      icon: Icon(icon, size: 14.0),
      label: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}