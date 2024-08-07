// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_reader/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookItemCard extends ConsumerWidget {
  final String title;
  final String author;
  final String language;
  final String subjects;
  final String? coverImageUrl;
  final bool loadingEffect;
  final Function onClick;
  const BookItemCard({
    super.key,
    required this.title,
    required this.author,
    required this.language,
    required this.subjects,
    this.coverImageUrl,
    this.loadingEffect = false,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 160.0,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Container(
          color: Theme.of(context).colorScheme.surfaceContainer,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Container(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      child: loadingEffect
                          ? const Text('Loading effect')
                          : CachedNetworkImage(
                              imageUrl: coverImageUrl ?? "",
                              placeholder: (context, url) => Image.asset(
                                Assets.drawable.placeholderCat
                                    .path,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontStyle: Theme.of(context)
                                .typography
                                .white
                                .headlineMedium
                                ?.fontStyle,
                            fontSize: 18.0,
                            fontFamily: Assets.fonts.figeronaBold,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                      child: Text(
                        author,
                        style: TextStyle(
                            fontStyle: Theme.of(context)
                                .typography
                                .white
                                .bodySmall
                                ?.fontStyle,
                            fontSize: 14.0,
                            fontFamily: Assets.fonts.figeronaRegular,
                            color: Theme.of(context).colorScheme.onSurface),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                      child: Text(
                        language,
                        style: TextStyle(
                            fontStyle: Theme.of(context)
                                .typography
                                .white
                                .bodyMedium
                                ?.fontStyle,
                            fontSize: 16.0,
                            fontFamily: Assets.fonts.figeronaSemibold,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                     Container(
                      padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                      child: Text(
                        subjects,
                        style: TextStyle(
                            fontStyle: Theme.of(context)
                                .typography
                                .white
                                .bodySmall
                                ?.fontStyle,
                            fontSize: 13.0,
                            fontFamily: Assets.fonts.figeronaRegular,
                            color: Theme.of(context).colorScheme.onSurface),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
