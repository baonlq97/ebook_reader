import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransitionFactory {
  // static CustomTransitionPage getSlideTransitionPage({
  //   required BuildContext context,
  //   required GoRouterState state,
  //   required Widget child,
  //   /*required bool leftToRight*/
  // }) {
  //   final tween = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero);
  // final slideAnimation = animation.drive(tween.chain(CurveTween(curve: Curves.easeInOut)));
  // final fadeAnimation = animation;

  // final fadeInTransition = FadeTransition(
  //   opacity: fadeAnimation,
  //   child: SlideTransition(
  //     position: slideAnimation,
  //     child: child,
  //   ),
  // );

  // final fadeOutTransition = FadeTransition(
  //   opacity: secondaryAnimation,
  //   child: SlideTransition(
  //     position: Tween<Offset>(begin: Offset.zero, end: const Offset(-1.0, 0.0)).animate(secondaryAnimation),
  //     child: child,
  //   ),
  // );

  // return CustomTransitionPage(
  //   key: ValueKey(child),
  //   child: fadeInTransition,
  //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //     return Stack(
  //       children: [
  //         Positioned.fill(
  //           child: FadeTransition(
  //             opacity: secondaryAnimation,
  //             child: SlideTransition(
  //               position: Tween<Offset>(begin: Offset.zero, end: const Offset(-1.0, 0.0))
  //                   .animate(secondaryAnimation),
  //               child: child,
  //             ),
  //           ),
  //         ),
  //         Positioned.fill(
  //           child: FadeTransition(
  //             opacity: animation,
  //             child: SlideTransition(
  //               position: tween.animate(animation),
  //               child: child,
  //             ),
  //           ),
  //         ),
  //       ],
  //     );
  //   },
  // );
  // }

  Page customPageTransition(Widget child, Animation<double> animation, Animation<double> secondaryAnimation) {
  final tween = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero);
  final slideAnimation = animation.drive(tween.chain(CurveTween(curve: Curves.easeInOut)));
  final fadeAnimation = animation;

  final fadeInTransition = FadeTransition(
    opacity: fadeAnimation,
    child: SlideTransition(
      position: slideAnimation,
      child: child,
    ),
  );

  final fadeOutTransition = FadeTransition(
    opacity: secondaryAnimation,
    child: SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: const Offset(-1.0, 0.0)).animate(secondaryAnimation),
      child: child,
    ),
  );

  return CustomTransitionPage(
    key: ValueKey(child),
    child: fadeInTransition,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return Stack(
        children: [
          Positioned.fill(
            child: FadeTransition(
              opacity: secondaryAnimation,
              child: SlideTransition(
                position: Tween<Offset>(begin: Offset.zero, end: const Offset(-1.0, 0.0))
                    .animate(secondaryAnimation),
                child: child,
              ),
            ),
          ),
          Positioned.fill(
            child: FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: tween.animate(animation),
                child: child,
              ),
            ),
          ),
        ],
      );
    },
  );
}
}
