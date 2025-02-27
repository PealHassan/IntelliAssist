import 'package:flutter/material.dart';
import 'package:intelliassist/route.dart';
import 'package:ionicons/ionicons.dart';

class SupportTeamPage extends StatelessWidget {
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
                  "Support Team",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            SizedBox(height: 30,),
            SupportMember(
              name: 'MD. Peal Hassan',
              email: 'pealhasan6@gmail.com',
              phone: '01779224826',
              image: 'assets/peal.jpg', // Path to image asset
            ),
            SupportMember(
              name: 'Pulok Saha',
              email: 'puloksaha.ayon@gmail.com',
              phone: '01750333646',
              image: 'assets/pulok.jpg', // Path to image asset
            ),
            SupportMember(
              name: 'Midu Mojumdar',
              email: 'midumojumder8@gmail.com',
              phone: '01794532606',
              image: 'assets/midu.jpg', // Path to image asset
            ),
            SupportMember(
              name: 'Fazla Rabbi',
              email: 'shahedrabbi955@gmail.com',
              phone: '8801718652134',
              image: 'assets/avatar.png', // Path to image asset
            ),
            SupportMember(
              name: 'Rubayet Adnan',
              email: 'rubayet9912@gmail.com',
              phone: '01943725798',
              image: 'assets/avatar.png', // Path to image asset
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
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SupportMember extends StatelessWidget {
  final String name;
  final String email;
  final String? phone;
  final String? additionalInfo;
  final String image;

  const SupportMember({
    Key? key,
    required this.name,
    required this.email,
    this.phone,
    this.additionalInfo,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(image),
                radius: 40.0,
              ),
              SizedBox(height: 10.0),
              Text(
                name,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                'Email: $email',
                style: TextStyle(fontSize: 14.0),
              ),
              if (phone != null) SizedBox(height: 5.0),
              if (phone != null)
                Text(
                  'Phone: $phone',
                  style: TextStyle(fontSize: 14.0),
                ),
              if (additionalInfo != null) SizedBox(height: 5.0),
              if (additionalInfo != null)
                Text(
                  additionalInfo!,
                  style: TextStyle(fontSize: 14.0),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


