import 'package:firebase_auth/firebase_auth.dart';
import 'package:skypeclone/models/user.dart';
import 'package:skypeclone/resources/firebase_methods.dart';

class FirebaseRepository{

  FirebaseMethods firebaseMethods = FirebaseMethods();

  Future<User> getCurrentUser() => firebaseMethods.getCurrentUser();

  Future<User> signIn() => firebaseMethods.signIn();

  Future<bool> authenticateUser(User user) => firebaseMethods.authenticateUser(user);

  Future<void> addDatatoDB(User user) => firebaseMethods.addDatatoDB(user); 

  Future<void> signOut() => firebaseMethods.signOut();

  Future<List<ModelUser>> getUsersList(User user) => firebaseMethods.getUsersList(user);

}