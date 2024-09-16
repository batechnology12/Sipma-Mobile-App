import 'package:flutter/material.dart';
import 'package:simpa/constands/constands.dart';


class OthersChatBubble extends StatelessWidget {
  String chat;
  String time;
  OthersChatBubble({super.key, 
    required this.chat,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 241, 241, 241)),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                chat.length > 30
                    ? SizedBox(
                        width: size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            chat,
                            style: primaryfont.copyWith(color: Colors.black87),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          chat,
                          style: primaryfont.copyWith(color: Colors.black87),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 10, 10, 5),
                  child: Text(
                    time,
                    style: primaryfont.copyWith(
                        color: Colors.black45, fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
