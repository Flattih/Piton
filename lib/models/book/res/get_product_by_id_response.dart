import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_product_by_id_response.g.dart';

@JsonSerializable()
class GetProductByIdResponse with EquatableMixin {
  @JsonKey(name: "product_by_pk")
  final ProductByPk? productByPk;

  GetProductByIdResponse({
    this.productByPk,
  });

  GetProductByIdResponse copyWith({
    ProductByPk? productByPk,
  }) =>
      GetProductByIdResponse(
        productByPk: productByPk ?? this.productByPk,
      );

  factory GetProductByIdResponse.fromJson(Map<String, dynamic> json) => _$GetProductByIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetProductByIdResponseToJson(this);

  @override
  List<Object?> get props => [productByPk];
}

@JsonSerializable()
class ProductByPk with EquatableMixin {
  final String? author;
  @JsonKey(name: "category_id")
  final int? categoryId;
  final String? cover;
  final String? description;
  final int? id;
  final String? name;
  final double? price;
  final int? sales;
  final String? slug;

  ProductByPk({
    this.author,
    this.categoryId,
    this.cover,
    this.description,
    this.id,
    this.name,
    this.price,
    this.sales,
    this.slug,
  });

  ProductByPk copyWith({
    String? author,
    int? categoryId,
    String? cover,
    String? description,
    int? id,
    String? name,
    double? price,
    int? sales,
    String? slug,
  }) =>
      ProductByPk(
        author: author ?? this.author,
        categoryId: categoryId ?? this.categoryId,
        cover: cover ?? this.cover,
        description: description ?? this.description,
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        sales: sales ?? this.sales,
        slug: slug ?? this.slug,
      );

  factory ProductByPk.fromJson(Map<String, dynamic> json) => _$ProductByPkFromJson(json);

  Map<String, dynamic> toJson() => _$ProductByPkToJson(this);

  @override
  List<Object?> get props => [author, categoryId, cover, description, id, name, price, sales, slug];
}
