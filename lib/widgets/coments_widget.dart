import 'package:flutter/material.dart';

class coments_widget extends StatelessWidget {
  const coments_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
            child: ListTile(
                leading: const CircleAvatar(radius: 40,
                  backgroundImage: AssetImage('assets/images/img.jpg'),
                ),
                title: Text("Names   $index"),
                subtitle: Text("Commanents  $index"),
                trailing: Text('$index Hours ago',style: const TextStyle(fontSize: 10),)),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
          );
        },
      );
  }
}