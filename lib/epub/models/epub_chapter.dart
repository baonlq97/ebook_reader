import 'package:equatable/equatable.dart';

class EpubChapter extends Equatable {
  final String absPath;
  final String title;
  final String body;

  const EpubChapter({
    required this.absPath,
    required this.title,
    required this.body,
  });

  @override
  List<Object> get props => [absPath, title, body];
}
