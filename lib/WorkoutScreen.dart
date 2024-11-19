import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state_management.dart';

class WorkoutScreen extends StatelessWidget {
  final TextEditingController _workoutTypeController = TextEditingController();
  final TextEditingController _workoutDurationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fitnessData = Provider.of<FitnessData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Log a New Workout'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField for entering the type of workout (e.g., Running, Yoga, etc.)
            TextField(
              controller: _workoutTypeController,
              decoration: InputDecoration(
                labelText: 'Enter Workout Type (e.g., Running, Yoga)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            // TextField for entering the workout duration in minutes
            TextField(
              controller: _workoutDurationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Workout Duration (minutes)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Button to submit the workout data
            ElevatedButton(
              onPressed: () {
                final String workoutType = _workoutTypeController.text;
                final int workoutDuration = int.tryParse(_workoutDurationController.text) ?? 0;

                // Add workout data to the fitness data model
                fitnessData.completeWorkout(workoutType, workoutDuration);

                // Clear the text fields after submission
                _workoutTypeController.clear();
                _workoutDurationController.clear();

                // Navigate back to the main screen
                Navigator.pop(context);
              },
              child: Text('Log Workout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
