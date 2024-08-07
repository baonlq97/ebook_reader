import 'package:ebook_reader/common/widgets/book_item_card.dart';
import 'package:ebook_reader/common/widgets/top_app_bar.dart';
import 'package:ebook_reader/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopAppBar(
            headerTitle: "All books", iconRes: Assets.drawable.icSearch),
        body: BookItemCard(
          title: "Crime and Punishment",
          author: "Fyodor Dostoyevsky",
          language: "English",
          subjects: "Crime, Psychological aspects, Fiction",
          coverImageUrl:
              "https://www.gutenberg.org/cache/epub/2554/pg2554.cover.medium.jpg",
          onClick: () => {},
        ));
  }
}
