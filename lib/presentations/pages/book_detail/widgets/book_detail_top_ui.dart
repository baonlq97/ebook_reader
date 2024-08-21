import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_reader/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class BookDetailTopUI extends StatelessWidget {
  final String title;
  final String authors;
  final String? imageData;
  final ThemeMode currentThemeMode;
  final bool showReaderBackground;
  final String? progressPercent;

  const BookDetailTopUI({
    super.key,
    required this.title,
    required this.authors,
    this.imageData,
    required this.currentThemeMode,
    this.showReaderBackground = false,
    this.progressPercent,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundImage = showReaderBackground
        ? Assets.drawable.bookReaderBg.path
        : Assets.drawable.bookDetailsBg.path;

    return SizedBox(
      width: double.infinity,
      height: 235.0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            backgroundImage,
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(0.35),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.surface.withAlpha(1),
                  Theme.of(context).colorScheme.surface,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0.01,
                  0.5,
                  1.0,
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 118.0,
                  height: 160.0,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 24.0,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: imageData != null
                      ? CachedNetworkImage(
                          imageUrl: imageData!,
                          placeholder: (context, url) =>
                              Image.asset(Assets.drawable.placeholderCat.path),
                          fit: BoxFit.cover,
                        )
                      : Image.asset(Assets.drawable.placeholderCat.path),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.headlineLarge?.color,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      authors,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (progressPercent != null)
                      Text(
                        '$progressPercent% Completed',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
