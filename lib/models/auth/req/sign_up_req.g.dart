// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpReq _$SignUpReqFromJson(Map<String, dynamic> json) => SignUpReq(
      email: json['email'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SignUpReqToJson(SignUpReq instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
    };
