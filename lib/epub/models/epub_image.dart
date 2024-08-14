import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class EpubImage extends Equatable {
  final String absPath;
  final Uint8List image;

  const EpubImage({
    required this.absPath,
    required this.image,
  });

  @override
  List<Object> get props => [absPath, image];
}
