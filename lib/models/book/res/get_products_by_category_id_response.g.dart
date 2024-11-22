// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_by_category_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductsByCategoryIdResponse _$GetProductsByCategoryIdResponseFromJson(
        Map<String, dynamic> json) =>
    GetProductsByCategoryIdResponse(
      product: (json['product'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetProductsByCategoryIdResponseToJson(
        GetProductsByCategoryIdResponse instance) =>
    <String, dynamic>{
      'product': instance.product,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      author: json['author'] as String?,
      cover: json['cover'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      description: json['description'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      sales: (json['sales'] as num?)?.toInt(),
      slug: json['slug'] as String?,
      likesAggregate: json['likes_aggregate'] == null
          ? null
          : LikesAggregate.fromJson(
              json['likes_aggregate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'author': instance.author,
      'cover': instance.cover,
      'created_at': instance.createdAt?.toIso8601String(),
      'description': instance.description,
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'sales': instance.sales,
      'slug': instance.slug,
      'likes_aggregate': instance.likesAggregate,
    };

LikesAggregate _$LikesAggregateFromJson(Map<String, dynamic> json) =>
    LikesAggregate(
      aggregate: json['aggregate'] == null
          ? null
          : Aggregate.fromJson(json['aggregate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LikesAggregateToJson(LikesAggregate instance) =>
    <String, dynamic>{
      'aggregate': instance.aggregate,
    };

Aggregate _$AggregateFromJson(Map<String, dynamic> json) => Aggregate(
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AggregateToJson(Aggregate instance) => <String, dynamic>{
      'count': instance.count,
    };
