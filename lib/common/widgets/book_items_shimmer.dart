import 'package:ebook_reader/common/widgets/book_item_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookItemsShimmer extends ConsumerWidget {
  const BookItemsShimmer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: 16,
      itemBuilder: (context, index) {
        return const Center(
          child: BookItemShimmer(
          ),
        );
      },
    );
  }
}
