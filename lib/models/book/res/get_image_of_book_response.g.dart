// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_image_of_book_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetImageOfBookResponse _$GetImageOfBookResponseFromJson(
        Map<String, dynamic> json) =>
    GetImageOfBookResponse(
      actionProductImage: json['action_product_image'] == null
          ? null
          : ActionProductImage.fromJson(
              json['action_product_image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetImageOfBookResponseToJson(
        GetImageOfBookResponse instance) =>
    <String, dynamic>{
      'action_product_image': instance.actionProductImage,
    };

ActionProductImage _$ActionProductImageFromJson(Map<String, dynamic> json) =>
    ActionProductImage(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ActionProductImageToJson(ActionProductImage instance) =>
    <String, dynamic>{
      'url': instance.url,
    };
