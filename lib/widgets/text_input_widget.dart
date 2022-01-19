import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputField extends StatefulWidget {
  TextInputField({Key? key,
    required this.labelText,
    required this.hintText,
    required this.isValid,
    required this.isLoading,
    this.textInputAction,
    this.errorMessage,
    this.initialValue,
    this.focusNext,
    this.prefix,
    this.prefixIcon,
    this.onChanged,
    this.shouldDrawSuffix,
    this.onSubmitted,
    this.focusNode,
    this.autofocus,
    this.textPosition,
    this.defaultFontWeight,
    this.keyboadType,
    this.maxLines,
    this.defaultBorder,
    this.labelStyle,
  }) : super(key: key);

  TextInputType? keyboadType;

  Widget? prefix;
  Widget? prefixIcon;
  bool? shouldDrawSuffix;

  final TextPosition? textPosition;

  final FocusNode? focusNode;

  final String? errorMessage;

  final bool isValid;

  final String? initialValue;

  final FocusNode? focusNext;

  final void Function(String)? onChanged;

  final void Function(String)? onSubmitted;

  late String labelText;

  late String hintText;
  late bool? autofocus;
  late FontWeight? defaultFontWeight;

  final TextInputAction? textInputAction;

  final int? maxLines;

  bool isLoading;

  InputBorder? defaultBorder;

  TextStyle? labelStyle;

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {

  final textEditingController = TextEditingController();

  FontWeight get _textFontWeight {
    if (widget.defaultFontWeight != null) {
      return widget.defaultFontWeight!;
    }
    if (widget.isValid) {
      return FontWeight.w700;
    }
    return FontWeight.w400;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialValue != null) {
      textEditingController.value = TextEditingValue(
        text: widget.initialValue!,
        selection: TextSelection.fromPosition(
          widget.textPosition ??
              TextPosition(offset: widget.initialValue!.length),
        ),
      );
    }

    return Container(
      child: TextField(
        autofocus: widget.autofocus != null ? widget.autofocus! : false,
        keyboardType: widget.keyboadType,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        focusNode: widget.focusNode,
        enabled: !widget.isLoading,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        maxLines: widget.maxLines ?? 1,
        controller: widget.initialValue != null ? textEditingController : null,
        textAlignVertical: TextAlignVertical.bottom,
        style: TextStyle(
            fontSize: 14,
            height: 1.05,
            color: Colors.black,
            fontWeight: _textFontWeight),
        decoration: InputDecoration(
            filled: true,
            helperText: widget.errorMessage,
            helperStyle: TextStyle(color: Colors.red),
            prefix: widget.prefix,
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            labelStyle: widget.labelStyle,
            labelText: widget.labelText),
      ),
    );
  }
}
