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
    ref.listen<AsyncValue<bool>>(splashInitializeProvider, (previous, next) {
      next.whenData((isFinished) {
        if (isFinished && ModalRoute.of(context)?.isCurrent == true) {
          context.go(AppRoute.home.path);
        }
      });
    });

    final AsyncValue<bool> initialFinished = ref.watch(splashInitializeProvider);
    
    return Scaffold(
      body: Center(
        child: initialFinished.when(
          data: (isFinished) {
            return const SizedBox.shrink();
          },
          loading: () => Lottie.asset(
            Assets.raws.welcomeLottie,
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}
