import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extra_info.g.dart';

@JsonSerializable()
class ExtraInfo extends Equatable {
  final String coverImage;
  final int pageCount;
  final String description;
  
  const ExtraInfo(
    this.coverImage,
    this.pageCount,
    this.description,
  );

  factory ExtraInfo.fromJson(Map<String, dynamic> json) => _$ExtraInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraInfoToJson(this);

  @override
  List<Object> get props => [coverImage, pageCount, description];
}
