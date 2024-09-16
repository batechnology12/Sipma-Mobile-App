import 'package:flutter/material.dart';

class InternetPage extends StatefulWidget {
  const InternetPage({super.key});

  @override
  State<InternetPage> createState() => _InternetPageState();
}

class _InternetPageState extends State<InternetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/internetimage22.png'),
            const SizedBox(
              height: 20,
            ),
            const Text('Check Your Internet',style: TextStyle(fontSize: 18),),
            const Text('Connection',style: TextStyle(fontSize: 18),)
          ],
        ),
      ),
    );
  }
}
