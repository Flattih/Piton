// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    SignUpResponse(
      actionRegister: json['action_register'] == null
          ? null
          : ActionRegister.fromJson(
              json['action_register'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{
      'action_register': instance.actionRegister,
    };

ActionRegister _$ActionRegisterFromJson(Map<String, dynamic> json) =>
    ActionRegister(
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ActionRegisterToJson(ActionRegister instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
