import 'package:flutter/material.dart';
import 'package:intelliassist/LoginPage.dart';

class components {
  static CustomTextField(TextEditingController controller,IconData iconData, String text,  bool toHide) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: text,
          hintStyle: TextStyle(color: Colors.black), // Set the color of the hint text to black
          prefixIcon: Icon(
            iconData,
            color: Colors.black, // Set the color of the icon to black
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
          // cursorColor: Colors.black, // Set the cursor color to black
        ),
      ),
    );
  }
  // static CustomeButton(VoidCallback voidCallback, String text) {
    // return Container(
      // padding: EdgeInsets.only(left: 20,right: 20),
    //   child: SizedBox(height: 50, width: 330, 
    //       child: ElevatedButton(onPressed: (){
    //         voidCallback();
    //       }, 
    //       child: Text(text,style: TextStyle(color: Colors.white,fontSize: 20),),
    //       style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: Colors.black,width: 2),)),
    //     ),
    //   ),
    // );  
  // }
  
  static CustomAlertBox(BuildContext context, String text, [bool isReg = false]) {
    return showDialog(context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Image.asset(
                'assets/error.png',
                width: 80,
                height: 40,
                                      // fit: BoxFit.cover,
              ),
              SizedBox(height: 20,),
              Text(
                "Error",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
          content: Container(
          height: 25,
          child: Center(child: Text(text,
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),))),
          actions: [
            TextButton(
              onPressed: () async{ 
                if(!isReg)Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));// Close the dialog
                else Navigator.pop(context);
              },
              child: Text(
                "OK",  
                style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ),
          ],
        );
      });
  }
  static CustomAlertBoxUpdate(BuildContext context, String text) {
    return showDialog(context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Image.asset(
                'assets/checked.png',
                width: 80,
                height: 40,
                                      // fit: BoxFit.cover,
              ),
              SizedBox(height: 20,),
              Text(
                "Updated",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ],
          ),
          content: Container(
          height: 25,
          child: Center(child: Text(text,
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),))),
          actions: [
            TextButton(
              onPressed: () async{ 
                Navigator.pop(context);
              },
              child: Text(
                "OK",  
                style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ),
          ],
        );
      });
  }
  static CustomAlertBoxSuccess(BuildContext context, String text, [bool isReg = false]) {
    return showDialog(context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Image.asset(
                'assets/checked.png',
                width: 80,
                height: 40,
                                      // fit: BoxFit.cover,
              ),
              SizedBox(height: 20,),
              Text(
                "Congratulations",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ],
          ),
          content: Container(
          height: 25,
          child: Center(child: Text(text,
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),))),
          actions: [
            TextButton(
              onPressed: () async{ 
                if(!isReg)Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));// Close the dialog
                else Navigator.pop(context);
              },
              child: Text(
                "OK",  
                style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),
              ),
            ),
          ],
        );
      });
  }
  
  
}
class CustomeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;

  const CustomeButton({
    required this.onPressed,
    required this.text,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white), 
        ) // Show circular progress indicator when isLoading is true
        : GestureDetector(
            onTap: onPressed,
            child: Container(
              height: 40,
              width: 310,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
