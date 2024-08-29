import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookItemShimmer extends StatelessWidget {
  const BookItemShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Theme.of(context).colorScheme.primary.withAlpha(40),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
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
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.0)),
                      margin: const EdgeInsets.only(left: 12.0, right: 8.0),
                      width: double.infinity,
                      height: 20.0,
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.0)),
                      margin: const EdgeInsets.only(left: 12.0, right: 8.0),
                      width: 80.0,
                      height: 20.0,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.0)),
                      margin: const EdgeInsets.only(left: 12.0, right: 8.0),
                      width: 60.0,
                      height: 20.0,
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.0)),
                      margin: const EdgeInsets.only(left: 12.0, right: 8.0),
                      width: 150.0,
                      height: 20.0,
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
