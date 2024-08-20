// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Formats _$FormatsFromJson(Map<String, dynamic> json) => Formats(
      textHtml: json['text/html'] as String?,
      applicationEpubZip: json['application/epub+zip'] as String?,
      applicationXmobiPocketEbook:
          json['application/x-mobipocket-ebook'] as String?,
      applicationRdfXml: json['application/rdf+xml'] as String?,
      imageJpeg: json['image/jpeg'] as String?,
      textPlainAscii: json['text/plain; charset=us-ascii'] as String?,
      applicationOctetStream: json['application/octet-stream'] as String?,
    );

Map<String, dynamic> _$FormatsToJson(Formats instance) => <String, dynamic>{
      'text/html': instance.textHtml,
      'application/epub+zip': instance.applicationEpubZip,
      'application/x-mobipocket-ebook': instance.applicationXmobiPocketEbook,
      'application/rdf+xml': instance.applicationRdfXml,
      'image/jpeg': instance.imageJpeg,
      'text/plain; charset=us-ascii': instance.textPlainAscii,
      'application/octet-stream': instance.applicationOctetStream,
    };
