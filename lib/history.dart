// historyPage.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intelliassist/chatScreen.dart';
import 'package:intelliassist/homePage.dart';
import 'package:intelliassist/sharedData.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Map<String, dynamic> userData = SharedData().getData();
  List<dynamic>messages = ["hello","Bro","Baby"];
  SharedData sharedData = SharedData();
  String? photoUrl = null;
  User? user;
  String email = "";  
  String uid = "";
  bool isLoading = false;  
  @override
  void initState() {
    super.initState();
    SharedData().addListener(_handleDataChange);
    getUser();
    messages = userData['messages'];
    photoUrl = userData['imageLink'];
  }

  @override
  void dispose() {
    SharedData().removeListener();
    super.dispose();
  }

  void _handleDataChange() {
    setState(() {
      userData = SharedData().getData();
    });
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
        setState(() {
          userData['imageLink'] = photoUrl;
          sharedData.setData(userData);
          SharedData().addListener(_handleDataChange);
          messages = userData['messages'];
        });
        print(userData['messages'][0]);
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
    List<String> stringMessages = messages.map((message) => message.toString()).toList();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Image.asset(
                'assets/homeScreen.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 30,),
                    (photoUrl != null)
                          ? CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(photoUrl!),
                            )
                          : Image.asset(
                              'assets/google_logo.png',
                              height: 50,
                              width: 50,
                            ),
                    SizedBox(width: 20,),
                    Text(
                      '${userData['firstname']} ${userData['lastname']}',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Roboto'),
                    ),
                  ],
                ),
                SizedBox(height: 25,),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      isLoading? CircularProgressIndicator(
                        color: Colors.white,
                        
                      ):GestureDetector(
                        onTap: () async{
                          setState(() {
                            isLoading = true;
                          });
                          await getUser();
                          await fetchUserData(email);
                          setState(() {
                            isLoading = false;
                          });
                          print('History icon tapped');
                        },
                        child: Icon(
                          Icons.history,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Recent',
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 20, color: Colors.white,),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: stringMessages.isEmpty?Container(
                    padding: EdgeInsets.only(top: 250),
                    child: Text("No Recent History",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    
                  ):Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: 320,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF040F16),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      itemCount: stringMessages.length,
                      itemBuilder: (context, index) {
                        String message = stringMessages.reversed.toList()[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => chatScreen(message)));
                                print('Message tapped: $message');
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                                child: Text(
                                  message,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                              height: 0,
                              indent: 20,
                              endIndent: 20,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
