// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_product_by_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductByIdResponse _$GetProductByIdResponseFromJson(
        Map<String, dynamic> json) =>
    GetProductByIdResponse(
      productByPk: json['product_by_pk'] == null
          ? null
          : ProductByPk.fromJson(json['product_by_pk'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetProductByIdResponseToJson(
        GetProductByIdResponse instance) =>
    <String, dynamic>{
      'product_by_pk': instance.productByPk,
    };

ProductByPk _$ProductByPkFromJson(Map<String, dynamic> json) => ProductByPk(
      author: json['author'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      cover: json['cover'] as String?,
      description: json['description'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      sales: (json['sales'] as num?)?.toInt(),
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$ProductByPkToJson(ProductByPk instance) =>
    <String, dynamic>{
      'author': instance.author,
      'category_id': instance.categoryId,
      'cover': instance.cover,
      'description': instance.description,
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'sales': instance.sales,
      'slug': instance.slug,
    };
