import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author extends Equatable {
  final String name;
  @JsonKey(name: 'birth_year')
  final int? birthYear;
  @JsonKey(name: 'death_year')
  final int? deathYear;

  const Author({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  @override
  List<Object?> get props => [name, birthYear, deathYear];
}