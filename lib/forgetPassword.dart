import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intelliassist/LoginPage.dart';
import 'package:intelliassist/components.dart';
import 'package:ionicons/ionicons.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _email = '';
  String _message = '';
  bool _isLoading = false;

  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      setState(() {
        _message = 'Password reset email sent. Please check your inbox.';
      });
    } on FirebaseAuthException catch (error) {
      setState(() {
        _message = 'Error: ${error.code.toString()}';
        if(_message == "Error: channel-error") _message = "Empty Email Field";
        components.CustomAlertBox(context, _message,true);
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Set app bar color to transparent
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                    "Forget Password",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 150,),
              Container(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 69, 65, 90),), // Set background color to ff7f50
                minimumSize: MaterialStateProperty.all(Size(120, 50)),
              ),
                onPressed: _isLoading ? null : _resetPassword,
                child: _isLoading
                    ? Container(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(color: Colors.white,))
                    : Text('Reset Password',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
              ),
              SizedBox(height: 20),
              Text(_message),
            ],
          ),
        ),
      ),
    );
  }
}
