

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skypeclone/resources/firebase_repository.dart';
import 'package:skypeclone/utils/helper_variabels.dart';
import 'package:skypeclone/utils/utilities.dart';
import 'package:skypeclone/widgets/app_bar.dart';
import 'package:skypeclone/widgets/custom_tile.dart';

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
            Navigator.pushNamed(context, "/search_screen");
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
      floatingActionButton: NewChatButton(),
      body: ChatListContainer(currUserId),
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
            child: initials == null?CircularProgressIndicator() : Text(
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

class NewChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: HelperVariabels.fabGradient,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 25,
      ),
      padding: EdgeInsets.all(15),
    );
  }
}

class ChatListContainer extends StatefulWidget {

  final String currUserId;

  ChatListContainer(this.currUserId);

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index){
          return CustomTile(
            mini: false,
            onTap: (){},
            title: Text("The Falcon",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Arial",
                fontSize: 19
              ),
            ),
            subtitle: Text("This is the Last Message",
              style: TextStyle(
                color: HelperVariabels.greyColor,
                fontSize: 14
              ),
            ),
            leading: Container(
              constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
              child: Stack(
                children: [
                  CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage("https://drive.google.com/uc?export=view&id=1-aDGmI6wymzPO-4MtNxSz5-8oWM1ppzu"),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 20,
                      width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: HelperVariabels.onlineDotColor,
                          border: Border.all(
                            color: HelperVariabels.blackColor,
                            width: 2
                          )
                        ),
                    ),
                  )
                ],
              ),
            ),
          );  
        },
      ),
    );
  }
}