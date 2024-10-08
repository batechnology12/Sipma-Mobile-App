import 'package:flutter/material.dart';

class appbar_leading extends StatelessWidget {
  appbar_leading({super.key, required this.title, this.imageurl});
  final String title;
  String? imageurl;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Image.asset(imageurl!)
        ],
      ),
      backgroundColor: Colors.white,
    );
                }
}
