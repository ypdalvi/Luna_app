import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luna/theme/pallete.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool isNumeric;
  const CustomTextField({
    Key? key,
    required this.isNumeric,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: (!isNumeric)
          ? null
          : <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r"^\d+\.?\d*"))
            ], //
      keyboardType: (!isNumeric)
          ? null
          : const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Pallete.darkestObjColor,
          )),
          hintStyle: const TextStyle(color: Colors.black),
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
