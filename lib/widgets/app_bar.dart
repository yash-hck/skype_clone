import 'package:flutter/material.dart';
import 'package:skypeclone/utils/helper_variabels.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  

  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final bool centerTile;

  const CustomAppBar({
    Key key, 
    this.title, 
    this.actions, 
    this.leading, 
    this.centerTile
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: HelperVariabels.blackColor,
        border: Border(
          bottom: BorderSide(
            color: HelperVariabels.separatorColor,
            width: 1.4,
            style: BorderStyle.solid
          )
        )
      ),
      child: AppBar(
        backgroundColor: HelperVariabels.blackColor,
        elevation: 0,
        leading: leading,
        actions: actions,
        centerTitle: centerTile,
        title: title,
      ),
    );
  }

  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10);
}