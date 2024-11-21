import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_req.g.dart';

@JsonSerializable()
class SignInReq with EquatableMixin {
  final String? email;
  final String? password;

  SignInReq({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$SignInReqToJson(this);

  @override
  List<Object?> get props => [email, password];
}
