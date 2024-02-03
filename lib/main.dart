import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xff141738),
        splashColor: const Color(0xffbbd0ff)

      ),
      home: const Homepage(),
    );
  }
}
