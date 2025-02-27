import 'package:flutter/material.dart';
import 'package:intelliassist/route.dart';
import 'package:ionicons/ionicons.dart';

class tosPage extends StatelessWidget {
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
                    "Terms of Services",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            SectionTitle(title: 'Registration Information'),
            TermsItem(
              title: 'Email and Password',
              description:
                  'By registering, you agree to provide a valid email address and create a secure password for your account. Your email will be used for account management and communication purposes.',
            ),
            TermsItem(
              title: 'Gender',
              description:
                  'Providing your gender information is optional and used for personalization purposes within the app.',
            ),
            TermsItem(
              title: 'Birthday',
              description:
                  'You agree to provide your date of birth for age verification purposes and to ensure compliance with applicable laws and regulations.',
            ),
            TermsItem(
              title: 'Profile Picture',
              description:
                  'You have the option to upload a profile picture, which will be visible to other users of the app. By uploading a picture, you certify that you have the necessary rights to use the image.',
            ),
            SectionTitle(title: 'Usage Agreement'),
            TermsItem(
              title: 'Acceptance of Terms',
              description:
                  'By using this app and its services, you agree to abide by these terms of service and any future updates or modifications.',
            ),
            TermsItem(
              title: 'Data Protection',
              description:
                  'We are committed to protecting your privacy and will only use your personal information in accordance with our privacy policy.',
            ),
            TermsItem(
              title: 'Account Security',
              description:
                  'You are responsible for maintaining the security of your account credentials and ensuring that they are not shared with unauthorized individuals.',
            ),
            TermsItem(
              title: 'Prohibited Activities',
              description:
                  'You agree not to engage in any illegal or unauthorized activities while using the app, including but not limited to spamming, hacking, or distributing malware.',
            ),
            TermsItem(
              title: 'Termination of Account',
              description:
                  'We reserve the right to suspend or terminate your account if you violate these terms of service or engage in any prohibited activities.',
            ),
            SectionTitle(title: 'Contact Us'),
            TermsItem(
              title: 'Questions or Concerns',
              description:
                  'If you have any questions or concerns about these terms of service or our app, please contact us at pealhasan6@gmail.com.',
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

class TermsItem extends StatelessWidget {
  final String title;
  final String description;

  const TermsItem({
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