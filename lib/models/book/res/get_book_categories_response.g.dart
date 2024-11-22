// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_book_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookCategoriesResponse _$GetBookCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    GetBookCategoriesResponse(
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => BookCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBookCategoriesResponseToJson(
        GetBookCategoriesResponse instance) =>
    <String, dynamic>{
      'category': instance.category,
    };

BookCategory _$BookCategoryFromJson(Map<String, dynamic> json) => BookCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$BookCategoryToJson(BookCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt?.toIso8601String(),
    };
