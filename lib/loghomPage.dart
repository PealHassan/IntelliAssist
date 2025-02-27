import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intelliassist/homePage.dart';
import 'package:intelliassist/sharedData.dart';

class loghomPage extends StatefulWidget {
  const loghomPage({super.key});

  @override
  State<loghomPage> createState() => _loghomPageState();
}

class _loghomPageState extends State<loghomPage> {
  User? user;
  String email = "";
  String uid = "";
  String username = "";
  String firstname = ""; 
  String lastname = "";
  String responseMessage = "";
  String text =""; 
  SharedData sharedData = SharedData();
  bool isdone = false;   
  @override
  void initState() {
    initializeUserAndFetchData(); 
    super.initState();
  }
  Future<void> initializeUserAndFetchData() async {
    await getUser(); 
    // Wait for user data to be fetched
    print(email);
    await fetchUserData(email);
    setState(() {
      isdone = true;
    }); // Wait for user data to be fetched before proceeding
  }
  Future<void> getUser() async{
    user = await FirebaseAuth.instance.currentUser;
    email = user!.email.toString();
    uid = user!.uid.toString();
  }
  Future<void> fetchUserData(String email) async {
    try {
      // Query Firestore for the user document based on UID
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      
      // Check if the user document exists
      if (userSnapshot.exists) {
        // Access user data
        Map<String, dynamic> userData = await userSnapshot.data() as Map<String, dynamic>;
        print(userData);
        setState(() {
          firstname = userData['firstname'];  
          // print(firstname);
          lastname = userData['lastname'];
          username = firstname + " " + lastname; 
          // print(userData);
          sharedData.setData(userData);
          
        });
        // print(userData['messages'][0]);
        print('User data: $userData');
      } else {
        print('User document does not exist');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    if(isdone) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage()));
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}