import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:skypeclone/resources/firebase_repository.dart';
import 'package:skypeclone/screens/login_screen.dart';
import 'package:skypeclone/screens/pages/chat_list_ui.dart';
import 'package:skypeclone/utils/helper_variabels.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseRepository _repository = FirebaseRepository();

  PageController _pageController;

  int pgNum = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController =  PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelperVariabels.blackColor,
      body: PageView(
        children: [
          Container(child: ChatListScreen(),),
          Center(child: Text('Call Logs'),),
          Center(child: Text('Contact Screen'),),
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CupertinoTabBar(
            backgroundColor: HelperVariabels.blackColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat,
                color: pgNum == 0?HelperVariabels.lightBlueColor: HelperVariabels.greyColor,
                ),
                title: Text('Chats',
                style: TextStyle(
                  fontSize: 15,
                  color: pgNum == 0?HelperVariabels.lightBlueColor:HelperVariabels.greyColor
                ),
                )
                
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.call,
                color: pgNum == 1?HelperVariabels.lightBlueColor: HelperVariabels.greyColor,
                ),
                title: Text('Calls',
                style: TextStyle(
                  fontSize: 15,
                  color: pgNum == 1?HelperVariabels.lightBlueColor:HelperVariabels.greyColor
                ),
                )
                
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.contacts,
                color: pgNum == 2?HelperVariabels.lightBlueColor: HelperVariabels.greyColor,
                ),
                title: Text('Contacts',
                style: TextStyle(
                  fontSize: 15,
                  color: pgNum == 2?HelperVariabels.lightBlueColor:HelperVariabels.greyColor
                ),
                )
                
              ),
              
            ],
            onTap: navigateToPage,
          ),
        )
      ),
    );
  }
        
  void onPageChanged(int page) {
    setState(() {
      pgNum = page;
    });
  }

  void navigateToPage(int page) {
    _pageController.jumpToPage(page);
  }
}