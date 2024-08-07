import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_notifier.g.dart';

@riverpod
Future<bool> splashInitialize(SplashInitializeRef ref) async {
  await Future.delayed(const Duration(milliseconds: 2000));
  return true;
}
