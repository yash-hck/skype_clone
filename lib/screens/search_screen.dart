import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:skypeclone/models/user.dart';
import 'package:skypeclone/resources/firebase_repository.dart';
import 'package:skypeclone/screens/chats/chat_screen.dart';
import 'package:skypeclone/utils/helper_variabels.dart';
import 'package:skypeclone/widgets/custom_tile.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
  FirebaseRepository _repository = FirebaseRepository();

  List<ModelUser> users = [];
  String query = "";
  TextEditingController searchController = TextEditingController();
  

  

  searchAppBar(BuildContext context){
    return NewGradientAppBar(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          HelperVariabels.gradientColorStart,
          HelperVariabels.gradientColorEnd
        ]
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back)
      ),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const  Size.fromHeight(kToolbarHeight + 15),
        child: Padding(
          padding: EdgeInsets.only(left: 25),
          child: TextField(controller: searchController,
            onChanged: (val){
              setState(() {
                query = val;
              });
            },
            cursorColor: HelperVariabels.blackColor,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 35
            ),

            decoration: InputDecoration(
              suffix: IconButton(
                onPressed: (){
                  searchController.clear();
                },
                color: Colors.white,
                icon: Icon(Icons.close)
              ),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(0x8fffffff)
              )

            ),
          ),
        ),
      )

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository.getCurrentUser().then((User user){
      _repository.getUsersList(user).then((List<ModelUser> userList){
        users = userList;
      });
    });
  }

  buildSuggession(String query){

    final List<ModelUser> list = query.isEmpty
          ? []
          : users.where((ModelUser user){
            String _getUsername = user.username.toLowerCase();
            String _query = query.toLowerCase();
            String _getName = user.name.toLowerCase();

            bool matchUserName = _getUsername.contains(query);
            bool matchName = _getName.contains(query);

            return matchName || matchUserName;

          }).toList();

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        ModelUser searchedUser = ModelUser(
          uid: list[index].uid,
          name: list[index].name,
          profilePhoto: list[index].profilePhoto,
          username: list[index].username,

        );

        return CustomTile(
          mini: false,
          onTap: (){
            Navigator.push(context, 
            MaterialPageRoute
              (builder: (context)=>ChatScreen(
                reciver: searchedUser,
              )));
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(searchedUser.profilePhoto),
            backgroundColor: Colors.grey,
          ),
          title: Text(
            searchedUser.username,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),

          ),
          subtitle: Text(
            searchedUser.name,
            style: TextStyle(
              color: HelperVariabels.greyColor
            ),
          ),
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelperVariabels.blackColor,
      appBar: searchAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: buildSuggession(query),
      ),
    );
  }
}