import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state_management.dart';
import 'main_screen.dart'; // Import MainScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FitnessData(),
      child: MaterialApp(
        title: 'ActiveLife: Health and Fitness Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainScreen(),  // Set MainScreen as the initial screen
      ),
    );
  }
}
