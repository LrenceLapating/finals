import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state_management.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _activeMinutesController = TextEditingController();
  final TextEditingController _hydrationController = TextEditingController();
  final TextEditingController _workoutTypeController = TextEditingController();
  final TextEditingController _workoutDurationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fitnessData = Provider.of<FitnessData>(context);

    String motivationalMessage = _getMotivationalMessage(fitnessData);

    return Scaffold(
      appBar: AppBar(
        title: Text('Log Your Fitness Data'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track your active minutes, hydration, and workouts here.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // Fitness card for active minutes, hydration, and workouts
            FitnessCard(
              title: 'Active Minutes',
              value: fitnessData.activeMinutes.toString(),
              icon: Icons.access_alarm,
            ),
            FitnessCard(
              title: 'Hydration (liters)',
              value: fitnessData.hydration.toString(),
              icon: Icons.local_drink,
            ),
            FitnessCard(
              title: 'Workouts Completed',
              value: fitnessData.workouts.length.toString(),
              icon: Icons.fitness_center,
            ),
            SizedBox(height: 20),

            // Motivational message
            Text(
              motivationalMessage,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),

            // Input fields for Active Minutes and Hydration
            TextField(
              controller: _activeMinutesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Active Minutes',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _hydrationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Hydration (liters)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Input fields for Workout Type and Duration
            TextField(
              controller: _workoutTypeController,
              decoration: InputDecoration(
                labelText: 'Enter Workout Type (e.g., Running, Yoga)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _workoutDurationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Workout Duration (minutes)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Submit button to log data
            ElevatedButton(
              onPressed: () {
                final int activeMinutes = int.tryParse(_activeMinutesController.text) ?? 0;
                final double hydration = double.tryParse(_hydrationController.text) ?? 0.0;
                final String workoutType = _workoutTypeController.text;
                final int workoutDuration = int.tryParse(_workoutDurationController.text) ?? 0;

                // Update the fitness data model with the new inputs
                fitnessData.addActiveMinutes(activeMinutes);
                fitnessData.addHydration(hydration);
                fitnessData.completeWorkout(workoutType, workoutDuration);

                // Clear the text fields after submission
                _activeMinutesController.clear();
                _hydrationController.clear();
                _workoutTypeController.clear();
                _workoutDurationController.clear();
              },
              child: Text('Log Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
            ),

            // Display the list of logged workouts
            SizedBox(height: 20),
            Text(
              'Logged Workouts:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Workout ListView (Table-like layout)
            Expanded(
              child: ListView.builder(
                itemCount: fitnessData.workouts.length,
                itemBuilder: (context, index) {
                  var workout = fitnessData.workouts[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    elevation: 5,
                    child: ListTile(
                      title: Text(workout['type']),
                      subtitle: Text('Duration: ${workout['duration']} minutes'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to generate motivational message based on input data
  String _getMotivationalMessage(FitnessData fitnessData) {
    if (fitnessData.activeMinutes > 60 && fitnessData.hydration >= 2.0) {
      return "You're doing great! Keep it up!";
    } else if (fitnessData.activeMinutes <= 30 && fitnessData.hydration < 1.5) {
      return "Try to stay active and hydrate more!";
    } else if (fitnessData.activeMinutes >= 30 && fitnessData.hydration >= 1.5) {
      return "Good job! Keep staying active and hydrated!";
    } else {
      return "Keep pushing! You're on the right track!";
    }
  }
}

class FitnessCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  FitnessCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title),
        subtitle: Text(value),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
