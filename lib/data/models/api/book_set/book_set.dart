import 'package:ebook_reader/data/models/api/book/book.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_set.g.dart';

@JsonSerializable()
class BookSet extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  @JsonKey(name: 'results')
  final List<Book> books;

  const BookSet({required this.count, required this.next, required this.previous, required this.books});
  
  factory BookSet.fromJson(Map<String, dynamic> json) =>
      _$BookSetFromJson(json);

  Map<String, dynamic> toJson() => _$BookSetToJson(this);
  
  @override
  List<Object?> get props => [count, next, previous, books];
}