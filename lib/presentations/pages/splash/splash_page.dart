import 'package:ebook_reader/gen/assets.gen.dart';
import 'package:ebook_reader/presentations/app_route.dart';
import 'package:ebook_reader/presentations/pages/splash/providers/splash_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<bool> initialFinished =
        ref.watch(splashInitializeProvider);

    ref.listen<AsyncValue<bool>>(splashInitializeProvider, (previous, next) {
      next.whenData((isFinished) {
        if (isFinished) {
          context.go(AppRoute.home.path);
        }
      });
    });
    return Scaffold(
        body: Center(
            child: initialFinished.when(
      data: (isFinished) {
        if (isFinished) {
          return Lottie.asset(Assets.raws.welcomeLottie);
        }
      },
      loading: () => Lottie.asset(
        Assets.raws.welcomeLottie,
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      ),
      error: (error, stack) => Text('Error: $error'),
    )));
  }
}
