import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intelliassist/LoginPage.dart';
import 'package:intelliassist/SupportTeam.dart';
import 'package:intelliassist/changePassword.dart';
import 'package:intelliassist/edit_screen.dart';
import 'package:intelliassist/feedback.dart';
import 'package:intelliassist/help.dart';
import 'package:intelliassist/history.dart';
import 'package:intelliassist/route.dart';
import 'package:intelliassist/setting_item.dart';
import 'package:intelliassist/setting_switch.dart';
import 'package:flutter/material.dart';
import 'package:intelliassist/forward_button.dart';
import 'package:intelliassist/sharedData.dart';
import 'package:intelliassist/tos.dart';
import 'package:ionicons/ionicons.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Map<String, dynamic> userData = SharedData().getData();
  // SharedData sharedData = SharedData();
  bool isDarkMode = false;
  User? user;
  String email = "";  
  String uid = "";
  String? photoUrl = null;
  @override
  void initState() {
    super.initState();
    initializeUserAndFetchData(); 
    
  }
  
//   void fetchuser() async {
//   try {
//     user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       String? photoURL = user!.photoURL;
//       if (photoURL != null && photoURL.isNotEmpty) {
//         setState(() {
//           photourl = photoURL;
//           isgooglePhoto = true;
//         });
//       } else {
//         setState(() {
//           // Fallback to default photo URL if user's photo URL is not available
//           photourl = "assets/avatar.png";
//           isgooglePhoto = false;
//         });
//       }
//     } else {
//       setState(() {
//         // Fallback to default photo URL if user is not logged in
//         photourl = "assets/avatar.png";
//         isgooglePhoto = false;
//       });
//     }
//   } catch (e) {
//     print("Error fetching user photo URL: $e");
//     // Handle error condition as needed
//   }
// }

  // void _handleDataChange() {
  //   setState(() async{
  //     userData = await SharedData().getData();
      
  //   });
  // }
  
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
      // extendBodyBehindAppBar: true,
      body: Container(
        
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 60,),
                Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      (photoUrl != null)
                          ? CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(photoUrl!),
                            )
                          : Image.asset(
                              'assets/avatar.png',
                              height: 50,
                              width: 50,
                            ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${userData['firstname']} ${userData['lastname']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ForwardButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditAccountScreen(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Management & Support",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                SettingItem(
                  title: "Feedback",
                  icon: Ionicons.chatbubble,
                  bgColor: Colors.blue.shade100,
                  iconColor: Colors.blue,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
                  },
                ),
                const SizedBox(height: 20),
                SettingItem(
                  title: "Change Password",
                  icon: Ionicons.lock_closed,
                  bgColor: Colors.purple.shade100,
                  iconColor: Colors.purple,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>changePasswordPage()));
                  },
                ),
                const SizedBox(height: 20),
                SettingItem(
                  title: "Help",
                  icon: Ionicons.nuclear,
                  bgColor: Colors.green.shade100,
                  iconColor: Colors.green,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
                  },
                ),
                const SizedBox(height: 20),
                SettingItem(
                  title: "Log Out",
                  icon: Ionicons.log_out,
                  bgColor: Colors.red.shade100,
                  iconColor: Colors.red,
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance.signOut();
                      // Clear user data when the user signs out
                      SharedData().clearUserData();
                      // await FirebaseAuth.instance.signOut();
                      // Navigate to the login screen or any other desired screen
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      
                    } catch (e) {
                      print('Error signing out: $e');
                    }
                  },
                ),
                const SizedBox(height: 20),
                SettingItem(
                  title: "Terms of Services",
                  icon: Ionicons.document_text_outline,
                  bgColor: Colors.orange.shade100,
                  iconColor: Colors.orange,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => tosPage()));
                  },
                ),
                const SizedBox(height: 20),
                SettingItem(
                  title: "Support Team",
                  icon: Ionicons.people_outline,
                  bgColor: Colors.teal.shade100,
                  iconColor: Colors.teal,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SupportTeamPage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> initializeUserAndFetchData() async {
    FirebaseAuth.instance.authStateChanges().listen((User? currentUser) {
      if (currentUser != null) {
        setState(() {
          user = currentUser;
          email = currentUser.email!;
          uid = currentUser.uid;
        });
        fetchUserData(email);
      } else {
        // User is signed out
        setState(() {
          user = null;
          email = "";
          uid = "";
        });
      }
    });
  }

  Future<void> fetchUserData(String email) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (userSnapshot.exists) {
        DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
          .collection('userProfile')
          .doc(uid)
          .get();
           if (profileSnapshot.exists) {
        setState(() {
          userData = userSnapshot.data() as Map<String, dynamic>;
          photoUrl = profileSnapshot['imageLink'];
          userData['imageLink'] = photoUrl;
        });
        
      } else {
        print('User document does not exist');
      }
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }
}