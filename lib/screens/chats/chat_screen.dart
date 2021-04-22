import 'package:flutter/material.dart';
import 'package:skypeclone/models/user.dart';


class ChatScreen extends StatefulWidget {

  final ModelUser reciver;

  ChatScreen({Key key, this.reciver}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final ModelUser reciver;

  _ChatScreenState({this.reciver});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}