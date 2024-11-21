import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:piton/core/common/app_text_field.dart';
import 'package:piton/core/extension/context_extension.dart';

class TitleWithTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool? isObscure;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;

  const TitleWithTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.isObscure,
    this.textInputAction,
    this.keyboardType,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const Gap(10),
        AppTextField(
          hintStyle: hintStyle,
          validator: validator,
          controller: controller,
          hintText: hintText,
        ),
      ],
    );
  }
}
