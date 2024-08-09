// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      authors: (json['authors'] as List<dynamic>)
          .map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      translators: (json['translators'] as List<dynamic>)
          .map((e) => Translator.fromJson(e as Map<String, dynamic>))
          .toList(),
      subjects:
          (json['subjects'] as List<dynamic>).map((e) => e as String).toList(),
      bookshelves: (json['bookshelves'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      copyright: json['copyright'] as bool,
      mediaType: json['media_type'] as String,
      formats: Formats.fromJson(json['formats'] as Map<String, dynamic>),
      downloadCount: (json['download_count'] as num).toInt(),
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authors': instance.authors,
      'translators': instance.translators,
      'subjects': instance.subjects,
      'bookshelves': instance.bookshelves,
      'languages': instance.languages,
      'copyright': instance.copyright,
      'media_type': instance.mediaType,
      'formats': instance.formats,
      'download_count': instance.downloadCount,
    };
