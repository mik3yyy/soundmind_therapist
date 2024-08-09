import 'package:auto_size_text/auto_size_text.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.suffixIcon,
      this.fillColor,
      this.keyboardType,
      this.obscureText = false,
      this.maxLength,
      this.maxLines,
      this.errorText,
      this.onChanged,
      this.textAlign,
      this.prefix,
      this.enabled,
      this.borderColor,
      this.onTap,
      this.labelText,
      this.focusNode,
      this.titleText,
      this.onEditingComplete,
      this.validator,
      this.textInputAction,
      this.isPasswordField = false});
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;

  final String hintText;
  final String? titleText;
  final String? labelText;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool obscureText;
  final bool? enabled;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final int? maxLength;
  final int? maxLines;
  final TextAlign? textAlign;
  final FormFieldValidator<String>? validator;
  final bool isPasswordField;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.titleText != null) ...[
            AutoSizeText(
              widget.titleText!,
              style: context.textTheme.bodyMedium,
            ),
            Gap(5),
          ],
          TextFormField(
            enabled: widget.enabled,
            controller: widget.controller,
            textAlign: widget.textAlign ?? TextAlign.start,

            // cursorHeight: 17,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPasswordField ? visible : widget.obscureText,
            cursorColor: context.colors.black,
            onChanged: widget.onChanged,
            maxLines: widget.maxLines ?? 1,
            validator: widget.validator,
            textInputAction: widget.textInputAction,
            maxLength: widget.maxLength,
            focusNode: widget.focusNode,
            onTap: widget.onTap,
            onEditingComplete: widget.onEditingComplete,
            decoration: InputDecoration(
              prefixIcon: widget.prefix,
              fillColor: widget.fillColor,
              filled: widget.fillColor != null,
              labelText: widget.labelText,
              errorText: widget.errorText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: widget.controller.text.isEmpty
                      ? context.colors.greyDecor
                      : widget.borderColor ?? context.primaryColor,
                ),
                gapPadding: 0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: widget.borderColor ??
                      Theme.of(context).colorScheme.primary,
                ),
                gapPadding: 0,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: widget.borderColor ??
                      Theme.of(context).colorScheme.primary,
                ),
                gapPadding: 0,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: widget.borderColor ??
                      Theme.of(context).colorScheme.primary,
                ),
                gapPadding: 0,
              ),
              hintText: widget.isPasswordField ? "●●●●●●●●" : widget.hintText,
              hintStyle: context.textTheme.bodyMedium,
              suffixIcon: widget.isPasswordField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                      icon: visible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off))
                  : widget.suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}

