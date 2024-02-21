part of '../ui_kit_part.dart';

class TextInputField extends StatefulWidget {
  final String name;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final Function(String?)? onChanged;
  final dynamic Function(String?)? valueTransformer;
  final bool? enabled;
  final void Function(String?)? onSaved;
  final AutovalidateMode? autovalidateMode;
  final void Function()? onReset;
  final FocusNode? focusNode;
  final String? restorationId;
  final String? initialValue;
  final bool? readOnly;
  final int? maxLines;
  final bool? obscureText;
  final TextCapitalization? textCapitalization;
  final EdgeInsets? scrollPadding;
  final bool? enableInteractiveSelection;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final TextAlign? textAlign;
  final bool? autofocus;
  final bool? autocorrect;
  final double? cursorWidth;
  final double? cursorHeight;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final int? maxLength;
  final void Function()? onEditingComplete;
  final void Function(String?)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final Widget? Function(
    BuildContext, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  })? buildCounter;
  final bool? expands;
  final int? minLines;
  final bool? showCursor;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool? enableSuggestions;
  final TextAlignVertical? textAlignVertical;
  final DragStartBehavior? dragStartBehavior;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final BoxWidthStyle? selectionWidthStyle;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final BoxHeightStyle? selectionHeightStyle;
  final Iterable<String>? autofillHints;
  final String? obscuringCharacter;
  final MouseCursor? mouseCursor;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  const TextInputField({
    super.key,
    required this.name,
    this.validator,
    this.decoration,
    this.onChanged,
    this.valueTransformer,
    this.enabled,
    this.onSaved,
    this.autovalidateMode,
    this.onReset,
    this.focusNode,
    this.restorationId,
    this.initialValue,
    this.readOnly,
    this.maxLines,
    this.obscureText,
    this.textCapitalization,
    this.scrollPadding,
    this.enableInteractiveSelection,
    this.maxLengthEnforcement,
    this.textAlign,
    this.autofocus,
    this.autocorrect,
    this.cursorWidth,
    this.cursorHeight,
    this.keyboardType,
    this.style,
    this.controller,
    this.textInputAction,
    this.strutStyle,
    this.textDirection,
    this.maxLength,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.buildCounter,
    this.expands,
    this.minLines,
    this.showCursor,
    this.onTap,
    this.onTapOutside,
    this.enableSuggestions,
    this.textAlignVertical,
    this.dragStartBehavior,
    this.scrollController,
    this.scrollPhysics,
    this.selectionWidthStyle,
    this.smartDashesType,
    this.smartQuotesType,
    this.selectionHeightStyle,
    this.autofillHints,
    this.obscuringCharacter,
    this.mouseCursor,
    this.contextMenuBuilder,
    this.magnifierConfiguration,
    this.contentInsertionConfiguration,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late bool _obscureText = widget.obscureText ?? false;
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.name,
      validator: widget.validator,
      decoration: widget.decoration ??
          ((widget.obscureText ?? false)
              ? InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() {
                      _obscureText = !_obscureText;
                    }),
                    child: Icon(_obscureText
                        ? Icons.remove_red_eye_outlined
                        : Icons.password),
                  ),
                )
              : const InputDecoration()),
      onChanged: widget.onChanged,
      valueTransformer: widget.valueTransformer,
      enabled: widget.enabled ?? true,
      onSaved: widget.onSaved,
      autovalidateMode: widget.autovalidateMode,
      onReset: widget.onReset,
      focusNode: widget.focusNode,
      restorationId: widget.restorationId,
      initialValue: widget.initialValue,
      readOnly: widget.readOnly ?? false,
      maxLines: widget.maxLines ?? 1,
      obscureText: _obscureText,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20),
      enableInteractiveSelection: widget.enableInteractiveSelection ?? true,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      textAlign: widget.textAlign ?? TextAlign.start,
      autofocus: widget.autofocus ?? false,
      autocorrect: widget.autocorrect ?? true,
      cursorWidth: widget.cursorWidth ?? 2.0,
      cursorHeight: widget.cursorHeight,
      keyboardType: widget.keyboardType,
      style: widget.style,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      maxLength: widget.maxLength,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      keyboardAppearance: widget.keyboardAppearance,
      buildCounter: widget.buildCounter,
      expands: widget.expands ?? false,
      minLines: widget.minLines,
      showCursor: widget.showCursor,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      enableSuggestions: widget.enableSuggestions ?? false,
      textAlignVertical: widget.textAlignVertical,
      dragStartBehavior: widget.dragStartBehavior ?? DragStartBehavior.start,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      selectionWidthStyle: widget.selectionWidthStyle ?? BoxWidthStyle.tight,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      selectionHeightStyle: widget.selectionHeightStyle ?? BoxHeightStyle.tight,
      autofillHints: widget.autofillHints,
      obscuringCharacter: widget.obscuringCharacter ?? '•',
      mouseCursor: widget.mouseCursor,
      contextMenuBuilder: widget.contextMenuBuilder,
      magnifierConfiguration: widget.magnifierConfiguration,
      contentInsertionConfiguration: widget.contentInsertionConfiguration,
    );
  }
}
