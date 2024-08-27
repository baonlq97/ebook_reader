import 'package:flutter/material.dart';

class BookDetailMiddleBar extends StatelessWidget {
  final String bookLang;
  final String pageCount;
  final String downloadCount;
  final double progressValue;
  final String buttonText;
  final bool showProgressBar;
  final VoidCallback onButtonClick;

  const BookDetailMiddleBar({
    super.key,
    required this.bookLang,
    required this.pageCount,
    required this.downloadCount,
    required this.progressValue,
    required this.buttonText,
    required this.showProgressBar,
    required this.onButtonClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showProgressBar)
          AnimatedOpacity(
            opacity: showProgressBar ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: LinearProgressIndicator(
                  value: progressValue > 0 ? progressValue : null,
                  minHeight: 8.0,
                  color: Theme.of(context).colorScheme.secondary,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .onSecondary
                      .withOpacity(0.3),
                ),
              ),
            ),
          ),
        SizedBox(
          height: 90.0,
          child: Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            color: const Color(0xFFE5F0F4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoColumn(
                  context,
                  Icons.language,
                  bookLang,
                ),
                // TODO: will add later
                // _buildVerticalDivider(context),
                // _buildInfoColumn(
                //   context,
                //   Icons.book,
                //   pageCount,
                // ),
                _buildVerticalDivider(context),
                _buildInfoColumn(
                  context,
                  Icons.download,
                  downloadCount,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 75.0,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: InkWell(
              onTap: onButtonClick,
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                height: 75.0,
                alignment: Alignment.center,
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoColumn(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24.0,
        ),
        const SizedBox(width: 4.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider(BuildContext context) {
    return Container(
      width: 2.0,
      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            height: constraints.maxHeight * 0.6,
          );
        },
      ),
    );
  }
}
