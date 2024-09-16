import 'package:flutter/material.dart';

class appbar extends StatelessWidget {
  const appbar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
    );
  }
}
