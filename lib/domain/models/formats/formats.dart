import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'formats.g.dart';

@JsonSerializable()
class Formats extends Equatable {
  @JsonKey(name: 'text/html')
  final String textHtml;

  @JsonKey(name: 'application/epub+zip')
  final String applicationEpubZip;

  @JsonKey(name: 'application/x-mobipocket-ebook')
  final String applicationXmobiPocketEbook;

  @JsonKey(name: 'application/rdf+xml')
  final String applicationRdfXml;

  @JsonKey(name: 'image/jpeg')
  final String imageJpeg;

  @JsonKey(name: 'text/plain; charset=us-ascii')
  final String textPlainAscii;

  @JsonKey(name: 'application/octet-stream')
  final String applicationOctetStream;

  const Formats({
    required this.textHtml,
    required this.applicationEpubZip,
    required this.applicationXmobiPocketEbook,
    required this.applicationRdfXml,
    required this.imageJpeg,
    required this.textPlainAscii,
    required this.applicationOctetStream,
  });

  factory Formats.fromJson(Map<String, dynamic> json) =>
      _$FormatsFromJson(json);

  Map<String, dynamic> toJson() => _$FormatsToJson(this);

  @override
  List<Object?> get props => [
        textHtml,
        applicationEpubZip,
        applicationXmobiPocketEbook,
        applicationRdfXml,
        imageJpeg,
        textPlainAscii,
        applicationOctetStream,
      ];
}
