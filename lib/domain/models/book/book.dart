import 'package:ebook_reader/domain/models/author/author.dart';
import 'package:ebook_reader/domain/models/formats/formats.dart';
import 'package:ebook_reader/domain/models/translator/translator.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'book.g.dart';

@JsonSerializable()
class Book extends Equatable {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'authors')
  final List<Author> authors;

  @JsonKey(name: 'translators')
  final List<Translator> translators;

  @JsonKey(name: 'subjects')
  final List<String> subjects;

  @JsonKey(name: 'bookshelves')
  final List<String> bookshelves;

  @JsonKey(name: 'languages')
  final List<String> languages;

  @JsonKey(name: 'copyright')
  final bool copyright;

  @JsonKey(name: 'media_type')
  final String mediaType;

  @JsonKey(name: 'formats')
  final Formats formats;

  @JsonKey(name: 'download_count')
  final int downloadCount;

  const Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.translators,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.formats,
    required this.downloadCount,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        authors,
        translators,
        subjects,
        bookshelves,
        languages,
        copyright,
        mediaType,
        formats,
        downloadCount,
      ];
}