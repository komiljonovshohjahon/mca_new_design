import 'package:flutter/services.dart';
import 'package:mca_new_design/template/base/template.dart';

class DefaultInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isObscured;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final VoidCallback? onSubmit;
  final bool enabled;
  final String? label;
  final double? width;
  final double? height;
  final TextInputType? textInputType;
  final ValueChanged? onChanged;
  final TextInputAction? textInputAction;
  DefaultInput(
      {this.hintText,
      this.controller,
      this.focusNode,
      this.textInputType,
      this.validator,
      this.textInputAction,
      this.onTap,
      this.height,
      this.width,
      this.label,
      this.onChanged,
      this.onSubmit,
      this.isObscured = false,
      this.enabled = true,
      this.prefixIcon});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        onEditingComplete: onSubmit,
        onChanged: onChanged,
        focusNode: focusNode,
        obscureText: isObscured,
        onTap: onTap,
        enabled: enabled,
        autofocus: false,
        validator: validator,
        textInputAction: textInputAction,
        controller: controller,
        style: ThemeTextRegular.base1.copyWith(color: ThemeColors.black),
        keyboardType: textInputType,
        decoration: InputDecoration(
          alignLabelWithHint: false,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          labelText: label?.tr,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          hintText: hintText?.tr,
          hintStyle: ThemeTextRegular.base1
              .copyWith(color: ThemeColors.black.withOpacity(0.31)),
          filled: true,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.mainBlue)),
          constraints: BoxConstraints.tight(Size(323.w, 51.h)),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          fillColor: ThemeColors.black.withOpacity(0.07),
        ),
      ),
    );
  }
}
