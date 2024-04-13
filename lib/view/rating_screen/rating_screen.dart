import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:prime_taxi_flutter_ui_kit/view/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RatingScreen(),
    );
  }
}

class RatingScreen extends StatefulWidget {
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 0;
  bool _ratingSubmitted = false;

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  void _submitRating() {
    debugPrint('Rating submitted: $_rating');
    // Check if rating has already been submitted
    if (!_ratingSubmitted) {
      _ratingSubmitted = true; // Set flag to indicate rating submission
      // Navigate to the home screen
      Get.off(() => HomeScreen()); // Use Get.off() to clear navigation stack
    }
  }

  @override
  void dispose() {
    // Dispose of any ongoing processes here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            // Handle navigation to home screen
          },
        ),
        automaticallyImplyLeading: false, // Remove back button
        title: Text('Rate Your Driver'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have arrived, rate your driver.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                  ),
                  onPressed: () => _setRating(index + 1),
                );
              }),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitRating,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
