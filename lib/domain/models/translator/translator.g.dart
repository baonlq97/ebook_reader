// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Translator _$TranslatorFromJson(Map<String, dynamic> json) => Translator(
      name: json['name'] as String,
      birthYear: (json['birth_year'] as num?)?.toInt(),
      deathYear: (json['death_year'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TranslatorToJson(Translator instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birth_year': instance.birthYear,
      'death_year': instance.deathYear,
    };
