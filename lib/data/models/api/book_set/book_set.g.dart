// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookSet _$BookSetFromJson(Map<String, dynamic> json) => BookSet(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      books: (json['results'] as List<dynamic>)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookSetToJson(BookSet instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.books,
    };
