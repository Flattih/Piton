import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_req.g.dart';

@JsonSerializable()
class SignUpReq with EquatableMixin {
  final String? email;
  final String? password;
  final String? name;

  SignUpReq({
    required this.email,
    required this.password,
    required this.name,
  });

  /// `SignUpReq` modelinden JSON'a dönüşüm
  Map<String, dynamic> toJson() => _$SignUpReqToJson(this);

  @override
  List<Object?> get props => [email, name, password];
}
