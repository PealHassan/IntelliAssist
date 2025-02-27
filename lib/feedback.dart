import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intelliassist/route.dart';
import 'package:intelliassist/settings.dart';
import 'package:ionicons/ionicons.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _feedbackController = TextEditingController();
  double _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Set app bar color to transparent
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RoutePage()));
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Text(
                    "Feedback",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Please provide your valuable feedback",
                    style: TextStyle(
                      fontSize: 15,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 60,),
              TextField(
                controller: _feedbackController,
                decoration: InputDecoration(
                  hintText: 'Enter your feedback',
                ),
              ),
              SizedBox(height: 50),
              Text('Rating: $_rating'),
              Slider(
                value: _rating,
                onChanged: (newRating) {
                  setState(() {
                    _rating = newRating;
                  });
                },
                min: 0,
                max: 5,
                divisions: 5,
                label: _rating.round().toString(),
              ),
              SizedBox(height: 20),
              Container(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Save feedback to Firestore
                      saveFeedback();
                    },
                    child: Text('Send Feedback', style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 69, 65, 90),), // Set background color to ff7f50
                      minimumSize: MaterialStateProperty.all(Size(120, 50)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveFeedback() {
    String feedbackText = _feedbackController.text.trim();
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid.toString();
    if (feedbackText.isNotEmpty) {
      // Save feedback to Firestore
      FirebaseFirestore.instance.collection('feedback').add({
        'text': feedbackText,
        'rating': _rating,
        'timestamp': FieldValue.serverTimestamp(),
        'uid': uid,
      }).then((_) {
        // Show success message or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Feedback sent successfully!'),
          ),
        );
        // Clear the feedback text field
        _feedbackController.clear();
        // Reset rating
        setState(() {
          _rating = 0.0;
        });
      }).catchError((error) {
        // Show error message if failed to save
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send feedback. Please try again later.'),
          ),
        );
      });
    } else {
      // Show error if feedback text is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your feedback.'),
        ),
      );
    }
  }
}
