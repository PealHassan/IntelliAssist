import 'dart:async';

import 'package:another_stepper/another_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intelliassist/LoginPage.dart';
import 'package:intelliassist/components.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});
  
  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  int _currentIndex = 0;
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();   
  TextEditingController lastNameController = TextEditingController();   
  TextEditingController passwordController = TextEditingController();   
  TextEditingController confirmPasswordController = TextEditingController();   
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  String otpController = "1234";

  PageController _pageController = PageController();   
  


  void dispose() {
    _pageController.dispose();
   
    super.dispose();
  }
  DateTime selectedDate = DateTime.now();
  String selectedValue = "Male";
  bool _isLoading = false;
  UserCredential? usercredential; 
  String emaill = "";
  
  EmailOTP myauth = EmailOTP();
  
  Register(String email, String password, String firstname, String lastname, String gender, DateTime dob) async{
      try {
        // emailController.clear();
        // passwordController.clear();
        // confirmPasswordController.clear();
        // firstNameController.clear();
        // lastNameController.clear();
        // selectedDate = DateTime.now();
        // selectedValue = 'Male';
        // FirebaseAuth.instance.sendPasswordResetEmail(email: email)
        
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
        User? user;
        user = FirebaseAuth.instance.currentUser;
        
        if(user != null) await user.delete();
        await myauth.setConfig(
          appEmail: "pealhasan6@gmail.com",
          appName: "IntelliAssist",
          userEmail: email,
          otpLength: 4,
          otpType: OTPType.digitsOnly);
        if (await myauth.sendOTP() == true) {
            print("OTP has been sent");
        } else {
            print("OTP SENT FAILED");
        }

        // usercredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        // user = FirebaseAuth.instance.currentUser;
        // String uid = user!.uid.toString();

    // Wait until email is verified
        
          // DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          // .collection('users')
          // .doc(uid)
          // .get();
          // if (!userSnapshot.exists) {
          //   DocumentReference userDocRef = FirebaseFirestore.instance
          //     .collection('users')
          //     .doc(uid);
          //   await userDocRef.set({
          //   'email': email,
          //   'firstname':firstname,
          //   'lastname' :lastname,
          //   'gender':selectedValue,
          //   'dob':selectedDate,
          //   'messages': [],
          // });  
          // }
          // components.CustomAlertBoxSuccess(context, "Registration is Successful");
        
      }
      on FirebaseAuthException catch(ex) {
        return components.CustomAlertBox(context, ex.code.toString());
      } finally {
        
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        // components.CustomAlertBoxSuccess(context, "Registration is Successful");
        
      }
    
  }
  Register2(String email, String password, String firstname, String lastname, String gender, DateTime dob) async{
      try {
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        firstNameController.clear();
        lastNameController.clear();
        selectedDate = DateTime.now();
        selectedValue = 'Male';
        
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())),
        User? user;
        usercredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
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
            'email': email,
            'firstname':firstname,
            'lastname' :lastname,
            'gender':selectedValue,
            'dob':selectedDate,
            'messages': [],
          });  
          }
          setState(() {
            isupdate = false;
          });
          components.CustomAlertBoxSuccess(context, "Registration is Successful");
        
      }
      on FirebaseAuthException catch(ex) {
        return components.CustomAlertBox(context, ex.code.toString());
      } finally {
        
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        // components.CustomAlertBoxSuccess(context, "Registration is Successful");
        
      }
    
  }
  bool isupdate = false;   
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      //   title: Text(''),
      // ),
      body: SingleChildScrollView(
        child: Stack(
          // fit: StackFit.expand,
          children: [
            // SizedBox(height: 30,),
            Positioned.fill(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 200),
              child: Image.asset(
                'assets/register.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
         
            Container(
              padding: EdgeInsets.only(top: 40),
              child: Column(
              
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 350),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 90),
                    child: Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // Adjust spacing between text and stepper
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.only(left: 25,right: 25),
                          child: Row(
                            children: [
                              stepperComponent(
                                index: 0,
                                
                                currentIndex: _currentIndex, onTap: () {  
                                  setState(() {
                                    _currentIndex = 0;
                                  });
                                  _pageController.jumpTo(0);
                                },
                                
                              ),
                              stepperComponent(
                                index: 1,
                                
                                currentIndex: _currentIndex, onTap: () {  
                                  setState(() {
                                    _currentIndex = 1;
                                  });
                                  _pageController.jumpTo(1);
                      
                                },
                              ),
                              stepperComponent(
                                index: 2,
                                
                                currentIndex: _currentIndex, onTap: () {  
                                  setState(() {
                                    _currentIndex = 2;
                                  });
                                  _pageController.jumpTo(2);
                      
                                },
                              ),
                              stepperComponent(
                                index: 3,
                                
                                currentIndex: _currentIndex, onTap: () {  
                                  setState(() {
                                    _currentIndex = 3;
                                  });
                                  _pageController.jumpTo(3);
                      
                                },
                              ),
                              stepperComponent(
                                index: 4,
                                currentIndex: _currentIndex, onTap: () {  
                                  setState(() {
                                    _currentIndex = 4;
                                  });
                                  _pageController.jumpTo(4);
                      
                                },
                              ),
                              stepperComponent(
                                currentIndex: _currentIndex, 
                                isLast: true,
                                index: 5, 
                                onTap: () {
                                  setState(() {
                                    _currentIndex = 5;
                                  });
                                  _pageController.jumpTo(5);
                                }
                              
                              ),
                              
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                          height: 400,// Set the height as per your requirement
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              if(_currentIndex == 0) {
                                return Container(
                                  padding: EdgeInsets.only(left: 50,right: 50,top: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Your Email',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
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
                                          
                                          controller: emailController,
                                          style: TextStyle(color: Colors.black), // Set text color to black
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white), // Set border color to white
                                              borderRadius: BorderRadius.circular(20), // Set border radius
                                            ),
                                            hintText: 'Enter your email',
                                            hintStyle: TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      ElevatedButton(
                                        
                                        onPressed: () {
                                          // print(emailController.text.toString().isEmpty);
                                          if(emailController.text.toString().isEmpty) {
                                            components.CustomAlertBox(context, "Requried Your Email",true);
                                            return;
                                          }
                                          setState(() {
                                            _currentIndex = 1;
                                          });
                                          _pageController.jumpTo(1);
                                          
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Color(0xffff7f50)), // Set background color to ff7f50
                                          minimumSize: MaterialStateProperty.all(Size(300, 50)),
                                        ),
                                        child: Text('Continue',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                );
                              }
                              else if(_currentIndex == 1) {
                                return Container(
                                  padding: EdgeInsets.only(left: 50,right: 50,top: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Your Full Name',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
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
                                          
                                          controller: firstNameController,
                                          style: TextStyle(color: Colors.black), // Set text color to black
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white), // Set border color to white
                                              borderRadius: BorderRadius.circular(20), // Set border radius
                                            ),
                                            hintText: 'First Name',
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
                                          
                                          controller: lastNameController,
                                          style: TextStyle(color: Colors.black), // Set text color to black
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.white), // Set border color to white
                                              borderRadius: BorderRadius.circular(20), // Set border radius
                                            ),
                                            hintText: 'Last Name',
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
                                              // print(emailController.text.toString().isEmpty);
                    
                                              setState(() {
                                                _currentIndex = 0;
                                              });
                                              _pageController.jumpTo(0);
                                              
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Color(0xffff7f50)), // Set background color to ff7f50
                                              minimumSize: MaterialStateProperty.all(Size(120, 50)),
                                            ),
                                            child: Text('Back',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            
                                            onPressed: () {
                                              // print(emailController.text.toString().isEmpty);
                                              if(emailController.text.toString().isEmpty || lastNameController.text.toString().isEmpty) {
                                                components.CustomAlertBox(context, "Required Empty Fields",true);
                                                return;
                                              }
                                              setState(() {
                                                _currentIndex = 2;
                                              });
                                              _pageController.jumpTo(2);
                                              
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Color(0xffff7f50)), // Set background color to ff7f50
                                              minimumSize: MaterialStateProperty.all(Size(120, 50)),
                                            ),
                                            child: Text('Continue',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      
                                    ],
                                  )
                                );
                              }
                              else if(_currentIndex == 2) {
                                return Container(
                                  padding: EdgeInsets.only(left: 50,right: 50,top: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Date of Birth',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8), // Adjust spacing between text and text field
                                      Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              "${selectedDate.toLocal()}".split(' ')[0],
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 20),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Color(0xffff7f50)), // Set background color to ff7f50
                                                minimumSize: MaterialStateProperty.all(Size(300, 50)),
                                              ),
                                              onPressed: () => _selectDate(context),
                                              child: Text('Select date',  
                                                  style: TextStyle(
                                                    color:  Colors.white,
                                                  ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
              
                                          ElevatedButton(
                                        
                                            onPressed: () {
                                              // print(emailController.text.toString().isEmpty);
                    
                                              setState(() {
                                                _currentIndex = 1;
                                              });
                                              _pageController.jumpTo(1);
                                              
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Color(0xffff7f50)), // Set background color to ff7f50
                                              minimumSize: MaterialStateProperty.all(Size(120, 50)),
                                            ),
                                            child: Text('Back',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            
                                            onPressed: () {
                                              // print(emailController.text.toString().isEmpty);
                                              if(emailController.text.toString().isEmpty || lastNameController.text.toString().isEmpty) {
                                                components.CustomAlertBox(context, "Required Empty Fields",true);
                                                return;
                                              }
                                              setState(() {
                                                _currentIndex = 3;
                                              });
                                              _pageController.jumpTo(3);
                                              
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Color(0xffff7f50)), // Set background color to ff7f50
                                              minimumSize: MaterialStateProperty.all(Size(120, 50)),
                                            ),
                                            child: Text('Continue',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      
                                    ],
                                  )
                                );
                
                              }
                              else if(_currentIndex == 3) {
                                return Container(
                                  padding: EdgeInsets.only(left: 50,right: 50,top: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(20),
                                        height: 60,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          color: Color(0xffff7f50), // Set the background color to orange
                                          borderRadius: BorderRadius.circular(8), // Optional: Add rounded corners
                                        ),
                                        child: DropdownButton<String>(
                                          isExpanded: true, // Change the type to nullable String
                                          value: selectedValue,
                                          onChanged: (String? newValue) { // Change the parameter type to nullable String
                                            setState(() {
                                              selectedValue = newValue!;
                                            });
                                          },
                                          items: <String>['Male', 'Female']
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          icon: null, // Hide default dropdown icon
                                          iconSize: 24, // Set the size of the custom icon
                                          underline: SizedBox(), // Hide underline
                                          style: TextStyle(color: Colors.white),
                                          selectedItemBuilder: (BuildContext context) {
                                            return <String>['Male', 'Female']
                                                .map<Widget>((String value) {
                                              return Center(
                                                child: Text(
                                                  value,
                                                  style: TextStyle(color: Colors.white), // Set text color
                                                ),
                                              );
                                            }).toList();
                                          },
                                          hint: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text('Select option', style: TextStyle(color: Colors.white)), // Set text color
                                              Icon(Icons.arrow_drop_down, color: Colors.white), // Set icon color
                                            ],
                                          ),// Set text color
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
              
                                          ElevatedButton(
                                        
                                            onPressed: () {
                                              // print(emailController.text.toString().isEmpty);
                    
                                              setState(() {
                                                _currentIndex = 2;
                                              });
                                              _pageController.jumpTo(2);
                                              
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Color(0xffff7f50)), // Set background color to ff7f50
                                              minimumSize: MaterialStateProperty.all(Size(120, 50)),
                                            ),
                                            child: Text('Back',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            
                                            onPressed: () {
                                              // print(emailController.text.toString().isEmpty);
                                              
                                              setState(() {
                                                _currentIndex = 4;
                                              });
                                              _pageController.jumpTo(4);
                                              
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Color(0xffff7f50)), // Set background color to ff7f50
                                              minimumSize: MaterialStateProperty.all(Size(120, 50)),
                                            ),
                                            child: Text('Continue',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      
                                    ],
                                  )
                                );
                
                              }
                              else if(_currentIndex == 4) {
                                return Container(
                                  padding: EdgeInsets.only(left: 50,right: 50,top: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Set Your Password',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
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
                                              // print(emailController.text.toString().isEmpty);
                    
                                              setState(() {
                                                _currentIndex = 3;
                                              });
                                              _pageController.jumpTo(3);
                                              
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Color(0xffff7f50)), // Set background color to ff7f50
                                              minimumSize: MaterialStateProperty.all(Size(120, 50)),
                                            ),
                                            child: Text('Back',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          _isLoading? CircularProgressIndicator(
                                            color: Colors.green, 
                                          ):ElevatedButton(
                                            
                                            onPressed: () async {
                                              emaill = emailController.text.toString();
                                              // print(emailController.text.toString().isEmpty);
                                              if(passwordController.text.toString().isEmpty || confirmPasswordController.text.toString().isEmpty) {
                                                components.CustomAlertBox(context, "Required Empty Fields",true);
                                                return;
                                              }
                                              if(passwordController.text.toString() != confirmPasswordController.text.toString()) {
                                                components.CustomAlertBox(context, "Password Doesn't Match",true);
                                                return;
                                              }
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              try {
                                                usercredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString());
                                              } on FirebaseAuthException catch(ex) {
                                                return components.CustomAlertBox(context, ex.code.toString());
                                              }
                                              setState(() {
                                                _currentIndex = 5;  
                                                _isLoading = false;
                                              });
                                              _pageController.jumpTo(5);
                                              
                                              
                                              Register(emailController.text.toString(), passwordController.text.toString(), firstNameController.text.toString(), lastNameController.text.toString(), selectedValue, selectedDate);
                                              
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.green), // Set background color to ff7f50
                                              minimumSize: MaterialStateProperty.all(Size(120, 50)),
                                            ),
                                            child: Text('Confirm',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      
                                    ],
                                  )
                                );
                              }
                              else if(_currentIndex == 5) {
                                
                                return Column(
                                  children: [
                                    SizedBox(height: 20,),
                                    Text(
                                      'You have been sent OTP via your email',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',  
                                        color:  Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      '$emaill',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Otp(
                                          otpController: otp1Controller,
                                        ),
                                        Otp(
                                          otpController: otp2Controller,
                                        ),
                                        Otp(
                                          otpController: otp3Controller,
                                        ),
                                        Otp(
                                          otpController: otp4Controller,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    isupdate?CircularProgressIndicator(
                                      color: Colors.green,
                                    ):ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color here
                                      ),
                                      onPressed: () async {
                                      if (await myauth.verifyOTP(otp: otp1Controller.text +
                                              otp2Controller.text +
                                              otp3Controller.text +
                                              otp4Controller.text) == true) {
                                          setState(() {
                                            isupdate = true;   
                                          });
                                          await Register2(emailController.text.toString(), passwordController.text.toString(), firstNameController.text.toString(), lastNameController.text.toString(), selectedValue, selectedDate);
                                        
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            content: Text("Invalid OTP"),
                                          ));
                                        }
                                      },
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(fontSize: 20,color: Colors.white),
                                      ),
                                    )
                                  ],
                                );
                                
                              }
                            },
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                ],
              ),
            )
        
          ],
        ),
      ),
    );  
  }
}

class stepperComponent extends StatelessWidget {
  int index;  
  int currentIndex;
  VoidCallback onTap;
  bool isLast;  
  List<String>pageName = [
    'Email', 
    'Name',  
    'Birthday',  
    'Gender',
    'Pass',
    'Verify',
  ];  
  stepperComponent({
    super.key,
    required this.currentIndex,
    required this.index,
    required this.onTap,
    this.isLast = false,
  });
  @override
  Widget build(BuildContext context) {
    return isLast? Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pageName[index],
            style: TextStyle(
              color: Color(0xffff7f50),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                  width: 30,
                  height: 30,
                  child: Icon(Icons.question_mark),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.green,
                    border: Border.all(
                      color: Colors.green,
                
                    ),
                  ),
                ),
            
              Container(
                height: 2,
                color: index+1 <= currentIndex?Color(0xffff7f50):Colors.white,
              ),
            ],
          ),
          
        ],
      ):Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pageName[index],
            style: TextStyle(
              color: Color(0xffff7f50),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
               Container(
                  width: 30,
                  height: 30,
                  child: index < currentIndex? Icon(Icons.check):Icon(Icons.edit),
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(100),
                    color: index <= currentIndex?Color(0xffff7f50):Colors.white,
                    border: Border.all(
                      color: index <= currentIndex?Color(0xffff7f50):Colors.white,
                
                    ),
                  ),
                ),
              
              Expanded(
                child: Container(
                  height: 2,
                  color: index+1 <= currentIndex?Color(0xffff7f50):Colors.white,
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
      
        decoration: const InputDecoration(
          hintText: ('0'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red), // Set the underline color here
          ),
        ),
        onSaved: (value) {},
      ),
    );
  }
}
