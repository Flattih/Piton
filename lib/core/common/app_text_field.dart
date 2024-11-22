import 'package:flutter/material.dart';
import 'package:piton/core/extension/context_extension.dart';
import 'package:piton/core/theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final bool isObscure;
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final int? maxLength;
  final String? counterText;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  const AppTextField(
      {super.key,
      this.hintText = "John Doe",
      this.isObscure = false,
      this.suffixIcon,
      this.hintStyle,
      this.validator,
      this.onTap,
      this.readOnly = false,
      this.keyboardType = TextInputType.text,
      this.maxLength,
      this.counterText,
      this.prefixIcon,
      this.contentPadding,
      this.onSubmitted,
      this.onChanged,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      keyboardType: keyboardType,
      readOnly: readOnly,
      controller: controller,
      obscureText: isObscure,
      maxLength: maxLength,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        filled: true,
        contentPadding: contentPadding,
        suffixIcon: suffixIcon,
        border: _outlinedBorder(),
        focusedBorder: _outlinedBorder(),
        enabledBorder: _outlinedBorder(),
        fillColor: AppColors.primaryColor,
        counterText: counterText,
        hintStyle: hintStyle ??
            context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.hintColor,
            ),
        hintText: hintText,
      ),
    );
  }

  OutlineInputBorder _outlinedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide.none,
    );
  }
}
