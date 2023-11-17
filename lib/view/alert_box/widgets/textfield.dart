import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({super.key, required this.labeltext,required this.controller});
  final String labeltext;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: widget.keyValue,
      textCapitalization: TextCapitalization.words,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return widget.validationText;
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.grey[250],
        labelText: labeltext,
        hintStyle: TextStyle(
          color: Colors.grey[500],
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(0, 158, 158, 158), width: 2.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(0, 158, 158, 158), width: 2.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(0, 158, 158, 158), width: 2.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        contentPadding: const EdgeInsets.fromLTRB(17.0, 2.0, 17.0, 16.0),
      ),
    );
  }
}
