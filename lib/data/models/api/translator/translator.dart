import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'translator.g.dart';

@JsonSerializable()
class Translator extends Equatable {
  final String name;
  @JsonKey(name: 'birth_year')
  final int? birthYear;
  @JsonKey(name: 'death_year')
  final int? deathYear;

  const Translator({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });

  factory Translator.fromJson(Map<String, dynamic> json) => _$TranslatorFromJson(json);

  Map<String, dynamic> toJson() => _$TranslatorToJson(this);

  @override
  List<Object?> get props => [name, birthYear, deathYear];
}