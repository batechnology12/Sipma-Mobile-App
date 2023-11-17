import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatImageView extends StatefulWidget {
  String image;
  ChatImageView({Key? key, required this.image}) : super(key: key);

  @override
  State<ChatImageView> createState() => _ChatImageViewState();
}

class _ChatImageViewState extends State<ChatImageView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SvgPicture.asset("assets/icons/Back.svg"),
                ),
              ],
            )),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: size.width,
          child: Image.network(
            widget.image,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
