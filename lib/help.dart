import 'package:flutter/material.dart';
import 'package:intelliassist/route.dart';
import 'package:ionicons/ionicons.dart';

class HelpPage extends StatelessWidget {
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
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                    "Help",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            SectionTitle(title: 'Getting Started'),
            HelpItem(
              title: 'How to access the chatbot within the app',
              description: 'Tap on the chatbot icon from the bottom navigation bar either you can start messaging using home screen \'message me\' box but in that case if from chatscreen you switch to another screen all the chats you did will be disappeared. Don\'t worry, from history page you can retreive your chats.',
            ),
            HelpItem(
              title: 'Steps to initiate a conversation',
              description: 'Simply type your query and press send icon.',
            ),
            HelpItem(
              title: 'Tips for interacting effectively',
              description:
                  'Be clear and concise in your queries for better responses.',
            ),
            SectionTitle(title: 'Query Types'),
            HelpItem(
              title: 'Admission Queries',
              description:
                  'For admission-related queries, specify the course or program you are interested in.',
            ),
            HelpItem(
              title: 'Course Information',
              description:
                  'Ask about course schedules, prerequisites, and faculty details.',
            ),
            HelpItem(
              title: 'Campus Facilities',
              description: 'Inquire about library, sports, accomodation, transportation and dining facilities.',
            ),
            HelpItem(
              title: 'Academic Calendar',
              description: 'Request information about important dates, such as exams and holidays.',
            ),
            HelpItem(
              title: 'Club Information',
              description:
                  'Ask about club\'s goals, club\'s basic information, their programmes and then decide which club suit you most.',
            ),
            SectionTitle(title: 'Features and Functions'),
            HelpItem(
              title: 'Language Support',
              description: 'The chatbot only supports English Language. So, you need to continue conversion through English.',
            ),
            HelpItem(
              title: 'Query Backup',
              description: 'Your all past queries are availabe to you. So, you can jump any of your query stage you did before.',
            ),
            SectionTitle(title: 'Troubleshooting'),
            HelpItem(
              title: 'Connection Issues',
              description: 'Check your internet connection and try again.',
            ),
            HelpItem(
              title: 'Loading for a long time',
              description: 'Check your internet connection and try again.',
            ),
            HelpItem(
              title: 'Instant Update not showing',
              description: 'After updating any information in your account settings, if the updates are not changed instantly wait for some time either log out and the log in again. You will be shown changes.',
            ),
            HelpItem(
              title: 'App Crashes',
              description: 'Restart the app or update to the latest version.',
            ),
            SectionTitle(title: 'University Resources'),
            HelpItem(
              title: 'Official Website',
              description: 'Visit the university website for additional information.',
            ),
            HelpItem(
              title: 'Department Contacts',
              description: 'Contact individual departments for specialized assistance.',
            ),
            SectionTitle(title: 'Feedback and Support'),
            HelpItem(
              title: 'Providing Feedback',
              description: 'We welcome your feedback to improve the chatbot experience.',
            ),
            HelpItem(
              title: 'Contact Support',
              description: 'For further assistance, please reach out to our support team. You can find our support team in support section.',
            ),
            SectionTitle(title: 'Privacy and Security'),
            HelpItem(
              title: 'Data Handling',
              description: 'User data is securely handled and not shared with third parties.',
            ),
            HelpItem(
              title: 'Password',
              description: 'Your account password is only visible to you, not even to the developer team. Even your queries are only visible to you. So, feel free to query using this app.',
            ),
            SectionTitle(title: 'Terms of Service'),
            HelpItem(
              title: 'Agreement Details',
              description: 'Read our terms of service for usage agreements and policies.',
            ),
            SectionTitle(title: 'Updates and Announcements'),
            HelpItem(
              title: 'Recent Updates',
              description: 'Stay informed about new features and improvements.',
            ),
            SectionTitle(title: 'Accessibility'),
            HelpItem(
              title: 'Accessibility Features',
              description: 'Explore accessibility options for users with disabilities.',
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
          color: Color.fromARGB(255, 85, 79, 112),
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class HelpItem extends StatelessWidget {
  final String title;
  final String description;

  const HelpItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            description,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}


