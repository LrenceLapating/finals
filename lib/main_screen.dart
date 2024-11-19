import 'package:flutter/material.dart';
import 'home_screen.dart';  // Import the HomeScreen (which now handles workout logging)

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ActiveLife: Health and Fitness Tracker'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(  // Center all the content on the MainScreen
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to ActiveLife!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,  // Center the text
              ),
              SizedBox(height: 20),
              Text(
                'Select an option to track your fitness data.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,  // Center the text
              ),
              SizedBox(height: 40),

              // Button to navigate to HomeScreen (Log Data)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text('Log Data'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
