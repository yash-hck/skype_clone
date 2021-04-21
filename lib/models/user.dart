import 'dart:convert';

class ModelUser {

  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String profilePhoto;


  ModelUser({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.status,
    this.state,
    this.profilePhoto,
  });
  


  Map<String, dynamic> toMap(ModelUser modelUser) {
    return {
      'uid': modelUser.uid,
      'name': modelUser.name,
      'email': modelUser.email,
      'username': modelUser.username,
      'status': modelUser.status,
      'state': modelUser.state,
      'profilePhoto': modelUser.profilePhoto,
    };
  }

   ModelUser.fromMap(Map<String, dynamic> map) {
    
      this.uid = map['uid'];
      this.name= map['name'];
      this.email =  map['email'];
      this.username = map['username'];
      this.status = map['status'];
      this.state = map['state'];
      this.profilePhoto = map['profilePhoto'];
    
  }


}
