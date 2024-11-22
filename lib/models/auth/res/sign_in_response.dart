import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_response.g.dart';

@JsonSerializable()
class SignInResponse with EquatableMixin {
  @JsonKey(name: "action_login")
  final ActionLogin? actionLogin;

  SignInResponse({
    this.actionLogin,
  });

  SignInResponse copyWith({
    ActionLogin? actionLogin,
  }) =>
      SignInResponse(
        actionLogin: actionLogin ?? this.actionLogin,
      );

  factory SignInResponse.fromJson(Map<String, dynamic> json) => _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);

  @override
  List<Object?> get props => [actionLogin];
}

@JsonSerializable()
class ActionLogin with EquatableMixin {
  final String? token;

  ActionLogin({
    this.token,
  });

  ActionLogin copyWith({
    String? token,
  }) =>
      ActionLogin(
        token: token ?? this.token,
      );

  factory ActionLogin.fromJson(Map<String, dynamic> json) => _$ActionLoginFromJson(json);

  Map<String, dynamic> toJson() => _$ActionLoginToJson(this);

  @override
  List<Object?> get props => [token];
}
