import 'package:ebook_reader/common/resources/data_state.dart';
import 'package:ebook_reader/data/models/api/author/author.dart';
import 'package:ebook_reader/data/models/api/book/book.dart';
import 'package:ebook_reader/data/models/api/book_set/book_set.dart';
import 'package:ebook_reader/data/models/api/formats/formats.dart';
import 'package:ebook_reader/data/models/api/translator/translator.dart';
import 'package:ebook_reader/data/repositories/book_repository_impl.dart';
import 'package:ebook_reader/di/providers/book_repository/book_repository_provider.dart';
import 'package:ebook_reader/presentations/notifiers/home/home_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_notifier_test.mocks.dart';

@GenerateMocks([
  BookRepository,
  BookSet,
  Book,
])

void main() {
  late MockBookRepository mockBookRepository;
  late ProviderContainer container;

  setUp(() {
    mockBookRepository = MockBookRepository();
    container = ProviderContainer(
      overrides: [
        bookRepositoryProvider.overrideWithValue(mockBookRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('HomeNotifier', () {
    test('initial state should be loading', () async {
      final initialBookSet = MockBookSet();

      // Stubbing _fetchBooks to return initialBookSet
      when(mockBookRepository.getAllBooks(1))
          .thenAnswer((_) async => DataSuccess(initialBookSet));

      final homeNotifier = container.read(homeNotifierProvider.notifier);

      // Check that the state is initially loading
      expect(homeNotifier.state, isA<AsyncLoading>());

      // Wait for the state to be updated to data
      await homeNotifier.build(); // To ensure the async operation completes
      expect(homeNotifier.state, isA<AsyncData<HomeState>>());
      expect(homeNotifier.state.value?.bookSet, initialBookSet);
    });

    test('fetchMoreBooks should update state correctly when successful',
        () async {
      // Setup mock responses

      final mockBook = MockBook();
      final mockBook2 = MockBook();
      final initialBookSet =
          BookSet(count: 10, next: '2', previous: null, books: [mockBook]);
      when(mockBook2.id).thenAnswer((_) => 2);
      final additionalBookSet =
          BookSet(count: 20, next: null, previous: '1', books: [mockBook2]);

      when(mockBookRepository.getAllBooks(1))
          .thenAnswer((_) async => DataSuccess(initialBookSet));
      when(mockBookRepository.getAllBooks(2))
          .thenAnswer((_) async => DataSuccess(additionalBookSet));

      final homeNotifier = container.read(homeNotifierProvider.notifier);

      // Trigger the initial build
      await homeNotifier.build();
      expect(homeNotifier.state, isA<AsyncData<HomeState>>());
      expect(homeNotifier.state.value?.bookSet, initialBookSet);
      expect(homeNotifier.state.value?.bookSet.books, contains(mockBook));
      expect(
          homeNotifier.state.value?.bookSet.books, isNot(contains(mockBook2)));

      // Trigger fetchMoreBooks
      await homeNotifier.fetchMoreBooks();
      expect(homeNotifier.state, isA<AsyncData<HomeState>>());
      expect(homeNotifier.state.value?.bookSet.books, contains(mockBook2));
      expect(homeNotifier.state.value?.isLoadingMore, false);
    });

    test('fetchMoreBooks should handle errors correctly', () async {
      when(mockBookRepository.getAllBooks(1)).thenAnswer((_) async =>
          DataSuccess(
              BookSet(count: 10, next: "2", previous: null, books: [])));
      when(mockBookRepository.getAllBooks(2))
          .thenThrow(Exception('Failed to fetch books'));

      final homeNotifier = container.read(homeNotifierProvider.notifier);

      await homeNotifier.build();
      await homeNotifier.fetchMoreBooks();
      expect(homeNotifier.state, isA<AsyncError>());
    });
  });
}
