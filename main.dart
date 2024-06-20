import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/team_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equipos de Fútbol',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TeamListScreen(),
    );
  }
}
