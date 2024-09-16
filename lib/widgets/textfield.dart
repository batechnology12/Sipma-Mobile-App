import 'package:flutter/material.dart';
import 'package:simpa/constands/constands.dart';

class TextformfieldWidget extends StatefulWidget {
  TextformfieldWidget({
    this.text,
    super.key,
    this.controller,
    this.textt,
    this.keyValue,
    this.isMandatory = false,
    this.validationText = "Value can't be empty",
    bool? autofocus,
  });
  // final String? Function(String?)? validator;
  String? text;
  String? textt;
  String? validationText;
  GlobalKey? keyValue;
  bool isMandatory;
  TextEditingController? controller;

  @override
  State<TextformfieldWidget> createState() => _TextformfieldWidgetState();
}

class _TextformfieldWidgetState extends State<TextformfieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Row(
              children: [
                Text(
                  widget.textt!,
                ),
                if (widget.isMandatory)
                  Text(
                    "*",
                    style: primaryfont.copyWith(color: Colors.red),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              key: widget.keyValue,
              textCapitalization: TextCapitalization.words,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller,
              validator: (value) {
                if (value!.isEmpty) {
                  return widget.validationText;
                }
                return null;
              },
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.grey[250],
                labelText: widget.text,
                hintStyle: TextStyle(fontSize: 12,
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
                      color: Color.fromARGB(0, 158, 158, 158), width: 1.0),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(0, 158, 158, 158), width: 1.0),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                contentPadding:
                    const EdgeInsets.fromLTRB(17.0, 2.0, 17.0, 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
