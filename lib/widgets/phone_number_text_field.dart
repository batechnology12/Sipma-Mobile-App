import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextPhoneformfieldWidget extends StatelessWidget {
  TextPhoneformfieldWidget({
    this.text,
    super.key,
    this.controller,
    this.textt,
    bool? autofocus,
  });
  // final String? Function(String?)? validator;
  String? text;
  String? textt;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textt!,
            ),
          ),
          TextFormField(
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return "$text can't be empty";
              } else if (value.length < 10) {
                return "$text must be 10 digits";
              }
              return null;
            },
            keyboardType: TextInputType.phone,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: Colors.grey[250],
              labelText: text,
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
              contentPadding: EdgeInsets.fromLTRB(17.0, 8.0, 17.0, 7.0),
            ),
          ),
        ],
      ),
    );
  }
}
