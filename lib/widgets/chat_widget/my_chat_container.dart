import 'package:flutter/material.dart';
import 'package:simpa/constands/constands.dart';
import 'package:simpa/models/chat_messages_model.dart';

class MyChatContainers extends StatelessWidget {
  String chat;
  String time;
  ChatMessages chatMessgae;
  MyChatContainers(
      {super.key, required this.chat, required this.time, required this.chatMessgae});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 248, 237, 235)),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                chat.length > 30
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: size.width * 0.5,
                          child: Text(
                            chat,
                            maxLines: 30,
                            style: primaryfont.copyWith(color: Colors.black87),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          chat,
                          maxLines: 30,
                          style: primaryfont.copyWith(color: Colors.black87),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 10, 0, 5),
                  child: Text(
                    time,
                    style: primaryfont.copyWith(color: kblue, fontSize: 13),
                  ),
                ),
                chatMessgae.isReaded
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(2, 10, 5, 5),
                        child: Icon(
                          Icons.done_all,
                          color: kblue,
                          size: 15,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(2, 10, 5, 5),
                        child: Icon(
                          Icons.done,
                          color: kblue,
                          size: 15,
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
