import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sign_up_response.g.dart';

@JsonSerializable()
class SignUpResponse with EquatableMixin {
  @JsonKey(name: "action_register")
  final ActionRegister? actionRegister;

  SignUpResponse({
    this.actionRegister,
  });

  SignUpResponse copyWith({
    ActionRegister? actionRegister,
  }) =>
      SignUpResponse(
        actionRegister: actionRegister ?? this.actionRegister,
      );

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);

  @override
  List<Object?> get props => [actionRegister];
}

@JsonSerializable()
class ActionRegister with EquatableMixin {
  @JsonKey(name: "token")
  final String? token;

  ActionRegister({
    this.token,
  });

  ActionRegister copyWith({
    String? token,
  }) =>
      ActionRegister(
        token: token ?? this.token,
      );

  factory ActionRegister.fromJson(Map<String, dynamic> json) => _$ActionRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$ActionRegisterToJson(this);

  @override
  List<Object?> get props => [token];
}
