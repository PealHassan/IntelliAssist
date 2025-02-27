import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';


import 'Messages.dart';


class chatScreen extends StatefulWidget {
  String m = "";
  chatScreen(String x){
    m = x;
  }
  // chatScreen({Key? key}):super(key: key);
  @override  
  _HomeState createState() => _HomeState(m);  
}

class _HomeState extends State<chatScreen> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  List<Map<String,dynamic>> messages = [];
  String m = "";

  User? user;
  String email = "";  
  String uid = "";
  late ScrollController _scrollController;
  _HomeState(String x) {
    m = x;
  }
  @override
  void initState() {
    super.initState();
    getUser();
    initializeDialogFlowtter();
    _scrollController = ScrollController();
  }
  Future<void> getUser() async{
    user = await FirebaseAuth.instance.currentUser;
    email = user!.email.toString();
    uid = user!.uid.toString();
    
  }
  Future<void> addUserMessage(String message) async {
  try {
    // Get a reference to the document within the userCollection corresponding to the user's UID
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid);
    
    // Get the current messages array from Firestore
    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    List<dynamic> messages = userDocSnapshot.get('messages') ?? [];

    // Check if the message already exists in the array
    if (messages.contains(message)) {
      // Remove the existing message from the array
      messages.remove(message);
    }
    
    // Add the new message to the array
    messages.add(message);
    
    // Update the document with the modified messages array
    await userDocRef.set({
      'email':email,
      'firstname':userDocSnapshot.get('firstname'),
      'lastname' : userDocSnapshot.get('lastname'),
      'gender' : userDocSnapshot.get('gender'),
      'dob' : userDocSnapshot.get('dob'),
      'messages': messages,
    });

    print('Message added to user collection successfully');
  } catch (error) {
    print('Error adding message to user collection: $error');
  }
}

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the ScrollController
    super.dispose();
  }

  Future<void> initializeDialogFlowtter() async {
    await DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    sendMessage(m);
    if(m.isNotEmpty) {
      print(m);
      await addUserMessage(m);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("IntelliAssist"),
      // ),
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/homeScreen.png"), // Replace this with your image path
          fit: BoxFit.cover,
        ),
      ),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Expanded(
              child: MessagesScreen(messages: messages, scrollController: _scrollController),
            ),
            Container(
          
              padding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8
              ),
              // color: Colors.deepPurple,
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
                                      if(_controller.text.toString().isNotEmpty) addUserMessage(_controller.text.toString());
                                      sendMessage(_controller.text.toString());
                                      _controller.clear();
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
      
    );   
  }

  sendMessage(String text) async {
  if (text.isEmpty) {
    print('Message is Empty');
  } else {
    setState(() {
      addMessage(Message(
        text: DialogText(
          text: [text],
        ),
      ), true);
    });
    print(dialogFlowtter);
    if (dialogFlowtter == null) {
      print('DialogFlowtter not initialized yet');
      return;
    }
    try {
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(text: TextInput(text: text)));
      print("hello look here2");
      print(response.message);
      if (response.message == null) {
        print("hello");
        return;
      }
      setState(() {
        print("hello");
        print(response.message);
        addMessage(response.message!);
      });
    } catch (e) {
      print("Error occurred: $e");
    }
  }
}

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message' : message,    
      'isUserMessage' : isUserMessage
    });
  }
}