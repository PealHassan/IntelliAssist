import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intelliassist/chatScreen.dart';
import 'package:intelliassist/sharedData.dart';
class homePage extends StatefulWidget {
  const homePage({super.key});
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  User? user;
  String email = "";
  String uid = "";
  String username = "";
  String firstname = ""; 
  String lastname = "";
  String responseMessage = "";
  String text =""; 
  String? photoUrl = null;  
  SharedData sharedData = SharedData();
  @override
  void initState() {
    super.initState();
    initializeUserAndFetchData(); 
    
  }
  
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Image.asset(
              'assets/homeScreen.png', // Replace with your image path
              fit: BoxFit.cover, // Cover the entire screen
            ),
              Container(
                  padding: EdgeInsets.only(top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 30,),
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
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Welcome Back,",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Roboto'),),
                              SizedBox(height: 2,),
                              Text(username,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Roboto'),),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 37,),
                      Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Text("Hi ",style: TextStyle(fontFamily: 'Roboto',fontSize: 20),),
                            Text(firstname,style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold,fontSize: 20),),
                          ],
                        )),
                        SizedBox(height: 10,),
                        Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Text("Your ",style: TextStyle(fontFamily: 'Roboto',fontSize: 20),),
                            Text("IntelliAssist",style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue),),
                          ],
                        )),
                        SizedBox(height: 10,),
                        Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Text("Companion",style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold,fontSize: 20),),
                            Text(" is Here!",style: TextStyle(fontFamily: 'Roboto',fontSize: 20),),
                          ],
                        )),
                        SizedBox(height: 10,),
                        Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Text("Instant answers,",style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold,fontSize: 20),),
                          ],
                        )),
                        SizedBox(height: 10,),
                        Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Text("Friendly",style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold,fontSize: 20),),
                          ],
                        )),
                        SizedBox(height: 10,),
                        Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Text("Conversation",style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold,fontSize: 20),),
                            
                          ],
                        )),
                        SizedBox(height: 10,),
                        Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Text("and",style: TextStyle(fontFamily: 'Roboto',fontSize: 20),),
                            Text(" Personalized",style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.bold,fontSize: 20),),
                          ],
                        )),
                        SizedBox(height: 10,),
                        Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Text("Assistance",style: TextStyle(fontFamily: 'Roboto',fontWeight:FontWeight.bold, fontSize: 20),),
                            Text(" are",style: TextStyle(fontFamily: 'Roboto',fontSize: 20),),
                          ],
                        )),
                        SizedBox(height: 10,),
                        Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Text("assured by me.",style: TextStyle(fontFamily: 'Roboto',fontSize: 20),),
                          ],
                        )),
                        SizedBox(height: 80,),
                        Center(
                          child: Container(
                            child: Text('How can i Help you ?',style: TextStyle(fontSize: 25,fontFamily: 'Roboto',fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                cursorColor: Colors.white,
                                controller: _controller, 
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  
                                  filled: true,
                                  fillColor: Colors.black,
                                  hintText: 'Message Me',
                                  hintStyle: TextStyle(color: Colors.white), // Set the color of the hint text to black
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      String m = _controller.text.toString();
                                      _controller.clear();
                                  
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => chatScreen(m)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder( // Customize border when enabled (not focused)
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.black), // Set the border color to black
                                  ),
                                  focusedBorder: OutlineInputBorder( // Customize border when focused
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.black), // Set the border color to black
                                  ),
                                   // Set the cursor color to black
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                        
                    ],
                  ),
                ),
            
          ],
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
          firstname = "";
          lastname = "";
          username = "";
          photoUrl = null;
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
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        setState(() {
          firstname = userData['firstname'];
          lastname = userData['lastname'];
          username = '$firstname $lastname';
          // print(photoUrl);
        });
        DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
          .collection('userProfile')
          .doc(uid)
          .get();
           if (profileSnapshot.exists) {
        setState(() {
          photoUrl = profileSnapshot['imageLink'];
          userData['imageLink'] = photoUrl;
        });
      } else {
        print('Profile document does not exist');
      }

        sharedData.setData(userData);
        
      } else {
        print('User document does not exist');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }
}