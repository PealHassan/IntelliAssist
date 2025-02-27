import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intelliassist/components.dart';
import 'package:ionicons/ionicons.dart';

class changePasswordPage extends StatefulWidget {
  const changePasswordPage({super.key});

  @override
  State<changePasswordPage> createState() => _changePasswordPageState();
}

class _changePasswordPageState extends State<changePasswordPage> {
  TextEditingController passwordController = TextEditingController();  
  TextEditingController confirmPasswordController = TextEditingController();  
  bool isConfirm = true;
  Future<void> changePassword(String newPassword) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
      components.CustomAlertBoxUpdate(context,'updated successfully');
      print('Password updated successfully');
    } else {
      // No user signed in
      print('No user signed in');
    }
  } on FirebaseAuthException catch(error) {
    components.CustomAlertBox(context, error.code.toString(), true);
    // Handle the error here
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Set app bar color to transparent
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
        title: Text('Change Password'),
      ),
      body : Container(
        padding: EdgeInsets.only(left: 50,right: 50,top: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Set Your New Password',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 8), // Adjust spacing between text and text field
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set background color to white
                borderRadius: BorderRadius.circular(20), // Set border radius
                border: Border.all(color: Colors.white), // Set border color to white
              ),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                style: TextStyle(color: Colors.black), // Set text color to black
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Set border color to white
                    borderRadius: BorderRadius.circular(20), // Set border radius
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 8), // Adjust spacing between text and text field
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set background color to white
                  borderRadius: BorderRadius.circular(20), // Set border radius
                    border: Border.all(color: Colors.white), // Set border color to white
              ),
              child: TextField(
                obscureText: true,
                controller: confirmPasswordController,
                style: TextStyle(color: Colors.black), // Set text color to black
                decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white), // Set border color to white
                borderRadius: BorderRadius.circular(20), // Set border radius
              ),
              hintText: 'Confirm Password',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(                         
              onPressed: () {
                Navigator.pop(context);
              },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 69, 65, 90),), // Set background color to ff7f50
              minimumSize: MaterialStateProperty.all(Size(120, 50)),
            ),
            child: Text('Back',
              style: TextStyle(
              color: Colors.white,
              ),
            ),
          ),
          isConfirm?ElevatedButton(                         
              onPressed: () async{
                setState(() {
                  isConfirm = false;
                });

                if(passwordController.text.toString().isEmpty || confirmPasswordController.text.toString().isEmpty) {
                  components.CustomAlertBox(context, "Required Empty Fields",true);
                  
                }
                else if(passwordController.text.toString() != confirmPasswordController.text.toString()) {
                  components.CustomAlertBox(context, "Password Doesn't Match",true);
                }
                else {
                  await changePassword(passwordController.text.toString());
                }

                setState(() {
                  passwordController.clear();
                  confirmPasswordController.clear();
                  isConfirm = true;
                });
              },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 69, 65, 90),), // Set background color to ff7f50
              minimumSize: MaterialStateProperty.all(Size(120, 50)),
            ),
            child: Text('Confirm',
              style: TextStyle(
              color: Colors.white,
              ),
            ),
          ):CircularProgressIndicator(),
        ],
      ),
        ],
        )),
    );
  }
}