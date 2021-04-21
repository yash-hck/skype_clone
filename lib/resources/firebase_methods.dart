import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skypeclone/models/user.dart';
import 'package:skypeclone/utils/utilities.dart';

class FirebaseMethods{

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ModelUser modelUser = ModelUser();

  Future<User> getCurrentUser() async{
    User CurrentUser;
    CurrentUser =  _auth.currentUser;

    return CurrentUser;

  }

  Future<User> signIn() async{
    
    GoogleSignInAccount signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication signInAuthentication = await signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: signInAuthentication.accessToken,
      idToken: signInAuthentication.idToken
    );

    UserCredential userCredential =  await _auth.signInWithCredential(credential);

    return userCredential.user;

  }

  Future<bool> authenticateUser(User user) async {

    QuerySnapshot result = await firestore.collection("users")
              .where("email", isEqualTo: user.email)
              .get();

    final List<DocumentSnapshot> list = result.docs;

    return list.length == 0? true: false;
    
  }

  Future<void> addDatatoDB(User user) async{
    
    String username = Utils.getUserName(user.email);

    modelUser = ModelUser(
      name: user.displayName,
      profilePhoto: user.photoURL,
      username: username,
      uid: user.uid,
      email: user.email
    );

    firestore.collection("users").doc(modelUser.uid).set(modelUser.toMap(modelUser));

  }

  Future<void> signOut() async {
   
    await _googleSignIn.signOut();
    
    return await _auth.signOut();
  }

}