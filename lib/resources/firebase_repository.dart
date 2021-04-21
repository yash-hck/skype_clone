import 'package:firebase_auth/firebase_auth.dart';
import 'package:skypeclone/resources/firebase_methods.dart';

class FirebaseRepository{

  FirebaseMethods firebaseMethods = FirebaseMethods();

  Future<User> getCurrentUser() => firebaseMethods.getCurrentUser();

}