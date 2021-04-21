import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseMethods{

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> getCurrentUser() async{
    User CurrentUser;
    CurrentUser =  _auth.currentUser;

    return CurrentUser;

  }

}