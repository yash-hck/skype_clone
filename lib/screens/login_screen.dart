import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skypeclone/resources/firebase_repository.dart';
import 'package:skypeclone/screens/home_screen.dart';
import 'package:skypeclone/utils/helper_variabels.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FirebaseRepository _repository = FirebaseRepository();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print('building');
    return Scaffold(
      backgroundColor: HelperVariabels.blackColor,
      body:Center(
        child: isLoading? CircularProgressIndicator(): loginButton(),
      ) 

      );
  }
    
  loginButton() {
    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: HelperVariabels.senderColor,
        child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              //side: BorderSide(color: Colors.red)
            )
          )
        ),
        onPressed: (){
          print('pressed');
          performLogin();
        },
        child: Text(
          "LOGIN",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2
          ),
        )
        
        ),
    );
  }

  void performLogin(){
    print("performing login");

    setState(() {
      isLoading = true;
    });

    _repository.signIn().then((User user){
      if(user != null){
        authenticateUser(user);
      }
      else{
        print("An Error Occurred");
      }
    });
  }
        
  void authenticateUser(User user) {

    

    _repository.authenticateUser(user).then((bool isNewUser){
      if(isNewUser){
        _repository.addDatatoDB(user);
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      }
      else{
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      }
    });
  }


}