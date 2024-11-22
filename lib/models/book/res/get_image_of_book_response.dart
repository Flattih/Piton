import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_image_of_book_response.g.dart';

@JsonSerializable()
class GetImageOfBookResponse with EquatableMixin {
  @JsonKey(name: "action_product_image")
  final ActionProductImage? actionProductImage;

  GetImageOfBookResponse({
    this.actionProductImage,
  });

  GetImageOfBookResponse copyWith({
    ActionProductImage? actionProductImage,
  }) =>
      GetImageOfBookResponse(
        actionProductImage: actionProductImage ?? this.actionProductImage,
      );

  factory GetImageOfBookResponse.fromJson(Map<String, dynamic> json) => _$GetImageOfBookResponseFromJson(json);

  @override
  List<Object?> get props => [actionProductImage];
}

@JsonSerializable()
class ActionProductImage with EquatableMixin {
  final String? url;

  ActionProductImage({
    this.url,
  });

  ActionProductImage copyWith({
    String? url,
  }) =>
      ActionProductImage(
        url: url ?? this.url,
      );

  factory ActionProductImage.fromJson(Map<String, dynamic> json) => _$ActionProductImageFromJson(json);

  @override
  List<Object?> get props => [url];
}
