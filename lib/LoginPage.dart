import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intelliassist/changePassword.dart';
import 'package:intelliassist/components.dart';
import 'package:intelliassist/forgetPassword.dart';
import 'package:intelliassist/homePage.dart';
import 'package:intelliassist/loghomPage.dart';
import 'package:intelliassist/registar.dart';
import 'package:intelliassist/route.dart';
import 'package:intelliassist/sharedData.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;  
  bool _isLoadingGoogle = false;  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  login(String email, String password) async{
    if(email == '' || password == "") {
      return components.CustomAlertBox(context,"Enter Required Fields");  
    }
    else {
      setState(() {
        _isLoading = true; // Start showing the progress indicator
      });
      UserCredential? usercredential;   
      try {
        emailController.clear();
        passwordController.clear();
        usercredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => 
          Navigator.push(context, MaterialPageRoute(builder: (context) => RoutePage())),
        );

      }
      on FirebaseAuthException catch(ex) {
        return components.CustomAlertBox(context, ex.code.toString());
      } finally {
         setState(() {
          _isLoading = false; // Start showing the progress indicator
        });
      }
    }
  }
  Future<void> signInWithGoogle() async {
    setState(() {
        _isLoadingGoogle = true; // Start showing the progress indicator
      });
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  UserCredential? usercredential,usercredential2; 
  User? user,guser;
  SharedData sharedData = SharedData();


  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  try {
    usercredential2 = await FirebaseAuth.instance.signInWithCredential(credential);
    guser = usercredential2.user;

    String name = guser!.displayName!;
    List<String> nameParts = name.split(" ");
    String firstname = nameParts[0];
    String lastname = nameParts.length > 1 ? nameParts[1] : '';
    user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid.toString();
    
    
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
    if (!userSnapshot.exists) {
      DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid);
      await userDocRef.set({
      'email': user!.email.toString(),
      'firstname':firstname,
      'lastname' :lastname,
      'gender' : 'Male',
      'dob' : DateTime.now(),
      'messages': [],
    });  
    }
    usercredential = await FirebaseAuth.instance.signInWithCredential(credential).then((value) =>
          Navigator.push(context, MaterialPageRoute(builder: (context) => RoutePage())),
    );
  }
  on FirebaseAuthException catch(ex) {
    setState(() {
      _isLoadingGoogle = false;
    });
    return components.CustomAlertBox(context, ex.code.toString());
  } finally {
      setState(() {
          _isLoadingGoogle = false; // Start showing the progress indicator
      });
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/loginScreen.png', // Replace with your image path
            fit: BoxFit.cover, // Cover the entire screen
          ),
          Container(
          decoration: BoxDecoration(
            // color: Colors.black,
            borderRadius: BorderRadius.circular(20.0), 
          ),
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.end, // Align at the bottom
            children: [
              components.CustomTextField(emailController,Icons.mail, "email", false),
              components.CustomTextField(passwordController, Icons.lock, "password", true),
              SizedBox(height: 2,),
            //  CustomButton(
            //     onPressed: () {
            //       login(emailController.text.toString(),
            //           passwordController.text.toString());
            //     },
            //     text: "NEXT",
            //     isLoading: _isLoading,
            //   ),
              
              CustomeButton(
                onPressed:() {
                  login(emailController.text.toString(),
                      passwordController.text.toString());
                }, 
                text:"NEXT", 
                isLoading: _isLoading,
                // isLoading: _isLoading
              ),
              TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                  }, 
                    child: Text("Reset Password",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
              SizedBox(height: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.0),
                      height: 1.0,
                      color: Colors.white, // Color of the line
                    ),
                  ),
                  Text(
                    'Or Log In With',
                    style: TextStyle(color: Colors.white), // Color of the text
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.0),
                      height: 1.0,
                      color: Colors.white, // Color of the line
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2,),
              _isLoadingGoogle?CircularProgressIndicator(
                color: Colors.white,
              ):Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      onPressed: () {
                        signInWithGoogle();
                      },
                      text: '',
                      logoPath: 'assets/google_logo.png',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),     
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => registerPage()));
                  }, 
                    child: Text("Register",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ), 
        ),
        ],
      ),
    );
  }
  
}
class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String logoPath;

  const CustomButton({
    required this.onPressed,
    required this.text,
    required this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 310,
        decoration: BoxDecoration(
          color: Colors.transparent, // Color for button
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logoPath,
              height: 40, // Adjust logo size as needed
            ), // Google icon
            SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

