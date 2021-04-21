import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {

  final Widget leading;
  final Widget title;
  final Widget icon;
  final Widget subtitle;
  final Widget trailing;
  final EdgeInsets margin;
  final bool mini;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;

  const CustomTile({
    Key key, 
    @required this.leading, 
    @required this.title, 
    this.icon, 
    @required this.subtitle,
    this.trailing, 
    this.margin = const EdgeInsets.all(0), 
    this.mini = true,
    this.onTap,
    this.onLongPress}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}