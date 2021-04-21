

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skypeclone/resources/firebase_repository.dart';
import 'package:skypeclone/utils/helper_variabels.dart';
import 'package:skypeclone/utils/utilities.dart';
import 'package:skypeclone/widgets/app_bar.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

//Global Variable
final FirebaseRepository _repository = FirebaseRepository();

class _ChatListScreenState extends State<ChatListScreen> {

  String currUserId;
  String initials;

  CustomAppBar customAppBar(context){
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(Icons.notifications,
        color: Colors.white,
        ),
        onPressed: (){

        },
        

      ),
      title: UserCircle(initials: initials,),
      centerTile: true,
      actions: [
        IconButton(
          icon: Icon(Icons.search,
          color: Colors.white,
          ),
          onPressed: (){

          },

        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print("build  Called");
    return Scaffold(
      backgroundColor: HelperVariabels.blackColor,
      appBar: customAppBar(context),
    );

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository.getCurrentUser().then((User user){
      setState(() {
        currUserId = user.uid;
        initials = Utils.getInitials(user.displayName);
      });
      print("inside init function initial - " + initials);
    });



  }

}

class UserCircle extends StatelessWidget {

  final String initials;

  UserCircle({this.initials});

  @override
  Widget build(BuildContext context) {
    print("inside build of userCircle - " + initials);
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: HelperVariabels.separatorColor
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              initials,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: HelperVariabels.lightBlueColor,
                fontSize: 13
              ),
            )
          ),
          
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: HelperVariabels.blackColor,
                  width: 2
                ),
                color: HelperVariabels.onlineDotColor

              ),
            ),
          ),
          

        ],
      ),
    );
  }
}