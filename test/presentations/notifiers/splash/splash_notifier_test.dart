import 'dart:async';

import 'package:ebook_reader/presentations/notifiers/splash/splash_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([Timer])

void main() {
  group('SplashNotifier', () {
    test('splashInitialize provider returns true after 2 seconds delay',
        () async {
      // Arrange
      final container = ProviderContainer();

      try {
        // Act
        // Read the future from the provider
        final future = container.read(splashInitializeProvider.future);

        // Assert
        // Wait for the future to complete
        final result = await future;
        // Verify that the result is true
        expect(result, isTrue);
      } finally {
        // Dispose the container after the test
        container.dispose();
      }
    });
  });
}
