import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class coments_widget extends StatelessWidget {
  const coments_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: ListTile(
                leading: CircleAvatar(radius: 40,
                  backgroundImage: AssetImage('assets/images/img.jpg'),
                ),
                title: Text("Names   $index"),
                subtitle: Text("Commanents  $index"),
                trailing: Text('$index Hours ago',style: TextStyle(fontSize: 10),)),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
          );
        },
      );
  }
}