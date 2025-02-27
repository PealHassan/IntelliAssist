import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intelliassist/add_data.dart';
import 'package:intelliassist/components.dart';
import 'package:intelliassist/edit_item.dart';
import 'package:flutter/material.dart';
import 'package:intelliassist/sharedData.dart';
import 'package:intelliassist/uploadImage.dart';
import 'package:intelliassist/utils.dart';
import 'package:ionicons/ionicons.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {

  String gender = "Male";
  User? user;  
  String email = "";  
  String uid = "";
  Map<String, dynamic> userData = SharedData().getData();
  late TextEditingController firstnameController,lastnameController;
  DateTime selectedDate = DateTime.now();
  Uint8List? _image;
  String? photoUrl = null;  
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
    
  }
  void saveProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    uid = user!.uid.toString();
    String resp = await StoreData().saveData(uid: uid, file: _image!);
  }

  @override
  void initState() {
    super.initState();
    initializeUserAndFetchData(); 
    firstnameController = TextEditingController(text : '${userData['firstname']}');
    lastnameController = TextEditingController(text: '${userData['lastname']}');
    gender = userData['gender'];
    selectedDate = (userData['dob'] as Timestamp).toDate();
    
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
  bool showUpdate = true;  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20,top: 20),
            child: showUpdate?ElevatedButton(onPressed: () async {
              setState(() {
                showUpdate = false;  
              });
              user = FirebaseAuth.instance.currentUser;
              String uid = user!.uid.toString();
              print(uid);
              if (true) {
                print('${uid} got');
                DocumentReference userDocRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid);
                await userDocRef.set({
                'email': userData['email'],
                'firstname':firstnameController.text.toString(),
                'lastname' :lastnameController.text.toString(),
                'gender' : gender,
                'dob' : selectedDate,
                'messages': userData['messages'],
              });  
              }
              saveProfile();
              components.CustomAlertBoxUpdate(context, "Updated Successfully");
              setState(() {
                showUpdate = true;
              });
            }, 
              child: Text('UPDATE',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 69, 65, 90),
              ),
            ):Container(
              height: 30,
              width: 50,
              padding: EdgeInsets.only(right: 20),
              child: CircularProgressIndicator(),
              
            ),
            
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              EditItem(
                title: "Photo",
                widget: Column(
                  children: [
                    _image != null? CircleAvatar(
                      radius: 50,
                      backgroundImage: MemoryImage(_image!),
                    ):(photoUrl != null)
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(photoUrl!),
                            ):
                            Image.asset(
                              'assets/avatar.png',
                              height: 50,
                              width: 50,
                            ),
                    SizedBox(height: 10,),
                    TextButton(
                      onPressed: selectImage,
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 69, 65, 90),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Upload Image"),
                    )
                  ],
                ),
              ),
              EditItem(
                title: "First Name",
                widget: TextField(
                  controller: firstnameController,
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Last Name",
                widget: TextField(
                  controller: lastnameController,
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Gender",
                widget: Column(
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: "Male",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                        Text("Male"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: "Female",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                        Text("Female"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              EditItem(
                title: "Date of Birth",
                widget: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: TextEditingController(
                        text: selectedDate != null
                            ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                            : "",
                      ),
                      decoration: InputDecoration(
                        hintText: "Select Date",
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
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
              firstnameController.text = userData['firstname'];
              lastnameController.text = userData['lastname'];
              gender = userData['gender'];
              selectedDate = (userData['dob'] as Timestamp).toDate();
              photoUrl = profileSnapshot['imageLink'];
              userData['imageLink'] = photoUrl;
            });
           }
        
      } else {
        print('User document does not exist');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }
}
