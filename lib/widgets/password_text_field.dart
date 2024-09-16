import 'package:flutter/material.dart';

class PassWordTextformfieldWidget extends StatefulWidget {
  PassWordTextformfieldWidget({
    this.text,
    super.key,
    this.controller,
    this.textt,
    this.keyValue,
    this.validationText = "Value can't be empty",
    bool? autofocus,
  });
  // final String? Function(String?)? validator;

  String? text;
  String? textt;
  String? validationText;
  GlobalKey? keyValue;
  TextEditingController? controller;

  @override
  State<PassWordTextformfieldWidget> createState() =>
      _PassWordTextformfieldWidgetState();
}

class _PassWordTextformfieldWidgetState
    extends State<PassWordTextformfieldWidget> {
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

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
              widget.textt!,
            ),
          ),
          TextFormField(
            key: widget.keyValue,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            validator: (value) {
              if (value!.isEmpty) {
                return widget.validationText;
              } else if (value.length < 8) {
                return "The password field must be at least 8 characters.";
              }
              return null;
            },
            obscureText: !_obscured,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: Colors.grey[250],
              labelText: widget.text,
              hintStyle: TextStyle(
                color: Colors.grey[500],
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: GestureDetector(
                  onTap: _toggleObscured,
                  child: Icon(
                    _obscured
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: Colors.grey,
                    size: 23,
                  ),
                ),
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
          ),
        ],
      ),
    );
  }
}
