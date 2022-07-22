import 'package:flutter/material.dart';
import 'package:kurilki/presentation/screens/home/home_screen.dart';
import 'package:kurilki/presentation/widgets/bottom_bar.dart';

import 'screens/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way',
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        primarySwatch: Colors.blue,
        fontFamily: "Gordita",
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [Expanded(child: HomeScreen()), BottomBar()],
          ),
        ),
      ),
    );
  }
}
