import 'package:ebook_reader/common/provider/bottom_navigation_app_bar/bottom_navigation_app_bar_provider.dart';
import 'package:ebook_reader/common/widgets/top_app_bar.dart';
import 'package:ebook_reader/data/models/database/library_item.dart';
import 'package:ebook_reader/gen/assets.gen.dart';
import 'package:ebook_reader/presentations/app_route.dart';
import 'package:ebook_reader/presentations/pages/library/providers/library_provider.dart'
    as provider;
import 'package:ebook_reader/presentations/pages/library/widgets/library_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryProvider = ref.watch(provider.libraryProvider);
    final libraryNotifier = ref.read(provider.libraryProvider.notifier);
    ref.listen(
      bottomNavigationAppBarProvider,
      (previous, next) {
        if (previous != BottomNavState.library &&
            next == BottomNavState.library) {
          ref.invalidate(provider.libraryProvider);
        }
      },
    );
    return Scaffold(
      appBar: TopAppBar(
        headerTitle: "Library",
        iconRes: Assets.drawable.icNavLibrary,
      ),
      body: libraryProvider.when(
        data: (data) {
          return data.isEmpty
              ? const Center(
                  child: Text("No Books Available"),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index]!;
                    if (!item.fileExists(item.filePath)) {
                      libraryNotifier.deleteItemFromDB(item);
                      return null;
                    }
                    return LibraryLazyItem(
                        item: item, notifier: libraryNotifier);
                  },
                );
        },
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Oops! Somethings went wrong"),
              ElevatedButton(
                child: const Text('Try Again'),
                onPressed: () {
                  ref.invalidate(provider.libraryProvider);
                },
              ),
            ],
          ),
        ),
        loading: () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class LibraryLazyItem extends StatelessWidget {
  final LibraryItem item;
  final provider.Library notifier;

  const LibraryLazyItem({
    super.key,
    required this.item,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Dismissible(
        key: ValueKey(item.id),
        background: Container(
          padding: const EdgeInsets.only(left: 20.0),
          color: Theme.of(context).colorScheme.primary,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [

                Icon(
                  Icons.read_more,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Read',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        secondaryBackground: Container(
          padding: const EdgeInsets.only(right: 20.0),
          color: Theme.of(context).colorScheme.primary,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Delete',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            GoRouter.of(context).push(
              AppRoute.bookReader.path,
              extra: {
                'libraryItem': item,
              },
            );
            return false;
          } else {
            _showDeleteDialog(context);
            return false;
          }
        },
        child: LibraryCard(
          title: item.title,
          author: item.authors,
          fileSize: item.getFileSize(item.filePath),
          date: item.getDownloadDate(item.createdAt),
          isExternalBook: false,
          onReadClick: () {
            GoRouter.of(context).push(
              AppRoute.bookReader.path,
              extra: {
                'libraryItem': item,
              },
            );
          },
          onDeleteClick: () => _showDeleteDialog(context),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Book"),
        content: const Text("Are you sure you want to delete this book?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final fileDeleted = item.deleteFile(item.filePath);
              if (fileDeleted) {
                await notifier.deleteItemFromDB(item);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Delete failed! Try again.')));
              }
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
