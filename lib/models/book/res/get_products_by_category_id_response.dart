import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_products_by_category_id_response.g.dart';

@JsonSerializable()
class GetProductsByCategoryIdResponse with EquatableMixin {
  final List<Product>? product;

  GetProductsByCategoryIdResponse({
    this.product,
  });

  GetProductsByCategoryIdResponse copyWith({
    List<Product>? product,
  }) =>
      GetProductsByCategoryIdResponse(
        product: product ?? this.product,
      );

  factory GetProductsByCategoryIdResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProductsByCategoryIdResponseFromJson(json);

  @override
  List<Object?> get props => [product];
}

@JsonSerializable()
class Product with EquatableMixin {
  final String? author;
  final String? cover;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  final String? description;
  final int? id;
  final String? name;
  final double? price;
  final int? sales;
  final String? slug;
  @JsonKey(name: "likes_aggregate")
  final LikesAggregate? likesAggregate;

  Product({
    this.author,
    this.cover,
    this.createdAt,
    this.description,
    this.id,
    this.name,
    this.price,
    this.sales,
    this.slug,
    this.likesAggregate,
  });

  Product copyWith({
    String? author,
    String? cover,
    DateTime? createdAt,
    String? description,
    int? id,
    String? name,
    double? price,
    int? sales,
    String? slug,
    LikesAggregate? likesAggregate,
  }) =>
      Product(
        author: author ?? this.author,
        cover: cover ?? this.cover,
        createdAt: createdAt ?? this.createdAt,
        description: description ?? this.description,
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        sales: sales ?? this.sales,
        slug: slug ?? this.slug,
        likesAggregate: likesAggregate ?? this.likesAggregate,
      );

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [author, cover, createdAt, description, id, name, price, sales, slug, likesAggregate];
}

@JsonSerializable()
class LikesAggregate with EquatableMixin {
  final Aggregate? aggregate;

  LikesAggregate({
    this.aggregate,
  });

  LikesAggregate copyWith({
    Aggregate? aggregate,
  }) =>
      LikesAggregate(
        aggregate: aggregate ?? this.aggregate,
      );

  factory LikesAggregate.fromJson(Map<String, dynamic> json) => _$LikesAggregateFromJson(json);

  Map<String, dynamic> toJson() => _$LikesAggregateToJson(this);

  @override
  List<Object?> get props => [aggregate];
}

@JsonSerializable()
class Aggregate with EquatableMixin {
  final int? count;

  Aggregate({
    this.count,
  });

  Aggregate copyWith({
    int? count,
  }) =>
      Aggregate(
        count: count ?? this.count,
      );

  factory Aggregate.fromJson(Map<String, dynamic> json) => _$AggregateFromJson(json);

  Map<String, dynamic> toJson() => _$AggregateToJson(this);

  @override
  List<Object?> get props => [count];
}
