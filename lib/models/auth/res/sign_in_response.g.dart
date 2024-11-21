// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      actionLogin: json['action_login'] == null
          ? null
          : ActionLogin.fromJson(json['action_login'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{
      'action_login': instance.actionLogin,
    };

ActionLogin _$ActionLoginFromJson(Map<String, dynamic> json) => ActionLogin(
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ActionLoginToJson(ActionLogin instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
