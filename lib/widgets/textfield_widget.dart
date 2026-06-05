import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  final String label;

  final IconData icon;

  final TextInputType keyboardType;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final FocusNode _focusNode = FocusNode();

  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),

      curve: Curves.easeOut,

      margin: const EdgeInsets.only(bottom: 16),

      decoration: BoxDecoration(
        color: secondaryColor,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          _isFocused
              ? BoxShadow(
                  color: primaryColor.withValues(alpha: 0.08),

                  blurRadius: 16,

                  offset: const Offset(0, 6),
                )
              : BoxShadow(
                  color: primaryColor.withValues(alpha: 0.04),

                  blurRadius: 10,

                  offset: const Offset(0, 6),
                ),
        ],

        border: Border.all(
          color: _isFocused ? primaryColor : greyLightColor,

          width: _isFocused ? 1.6 : 1,
        ),
      ),

      child: TextFormField(
        controller: widget.controller,

        focusNode: _focusNode,

        keyboardType: widget.keyboardType,

        style: textFieldInputStyle,

        decoration: InputDecoration(
          labelText: widget.label,

          labelStyle: _isFocused ? focusedLabelStyle : unFocusedLabelStyle,

          prefixIcon: Container(
            margin: const EdgeInsets.all(10),

            padding: const EdgeInsets.all(8),

            decoration: BoxDecoration(
              color: _isFocused
                  ? primaryColor.withValues(alpha: 0.12)
                  : Colors.grey.shade100,

              borderRadius: BorderRadius.circular(10),
            ),

            child: Icon(
              widget.icon,

              color: _isFocused ? primaryColor : greyTextColor,

              size: 20,
            ),
          ),

          border: InputBorder.none,

          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,

            horizontal: 14,
          ),

          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),

        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Enter ${widget.label}";
          }

          if (widget.label == "Phone Number") {
            if (value.length != 10) {
              return "Enter valid phone number";
            }
          }

          if (widget.label == "PinCode") {
            if (value.length != 6) {
              return "Enter valid pinCode";
            }
          }

          return null;
        },
      ),
    );
  }
}
