// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraInfo _$ExtraInfoFromJson(Map<String, dynamic> json) => ExtraInfo(
      json['coverImage'] as String,
      (json['pageCount'] as num).toInt(),
      json['description'] as String,
    );

Map<String, dynamic> _$ExtraInfoToJson(ExtraInfo instance) => <String, dynamic>{
      'coverImage': instance.coverImage,
      'pageCount': instance.pageCount,
      'description': instance.description,
    };
