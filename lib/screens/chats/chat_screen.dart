import 'package:flutter/material.dart';
import 'package:skypeclone/models/user.dart';
import 'package:skypeclone/utils/helper_variabels.dart';
import 'package:skypeclone/widgets/app_bar.dart';
import 'package:skypeclone/widgets/custom_tile.dart';


class ChatScreen extends StatefulWidget {

  final ModelUser reciver;

  ChatScreen({Key key, this.reciver}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final ModelUser reciver;
  bool isWriting = false;
  TextEditingController messageController = TextEditingController();

  _ChatScreenState({this.reciver});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelperVariabels.blackColor,
      appBar: customAppbar(context),
      body: Column(
        children: [
          Flexible(
            child: messageList(),
          ),

          chatControls()
        ],
      ),
    );
  }
  

  Widget messageList(){
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return chatMesaageItem();
      },
    );
  }

  Widget chatMesaageItem(){
    return Container(
      //constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.65),
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerRight,
      child: senderLayout(),
    );
  }

  Widget senderLayout() {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: HelperVariabels.senderColor,
        borderRadius: BorderRadius.only(
          topLeft: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Hello",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

   Widget reciverLayout(){
    Radius messageRadius = Radius.circular(20);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width*0.65

      ),
      decoration: BoxDecoration(
        color: HelperVariabels.receiverColor,
        borderRadius: BorderRadius.only(
          bottomRight: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius
        )
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Hello",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        ),
      ),
    );
  }

  addMediaModel(BuildContext context){
    showModalBottomSheet(context: context,
      elevation: 0,
      backgroundColor: HelperVariabels.blackColor,
      builder: (context){
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(children: [
                TextButton(onPressed: ()=>Navigator.pop(context),
                 child: Icon(Icons.close)
                 ),
                 Expanded(
                   child: Align(
                     alignment: Alignment.centerLeft,
                     child: Text(
                       "Content And Styles",
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 20,
                         fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                 )
              ],),
            ),
            Flexible(
              child: ListView(children: [
                ModelTile(title: "Media", subtitle: "SharePhotos", icon: Icons.image),
                ModelTile(
                    title: "File",
                    subtitle: "Share files",
                    icon: Icons.tab),
                ModelTile(
                    title: "Contact",
                    subtitle: "Share contacts",
                    icon: Icons.contacts),
                ModelTile(
                    title: "Location",
                    subtitle: "Share a location",
                    icon: Icons.add_location),
                ModelTile(
                    title: "Schedule Call",
                    subtitle: "Arrange a skype call and get reminders",
                    icon: Icons.schedule),
                ModelTile(
                    title: "Create Poll",
                    subtitle: "Share polls",
                    icon: Icons.poll)
              ],)
            )
          ],
        );
      }
    );
  }


  Widget chatControls(){

    setWriting(bool val){
      setState(() {
        isWriting = val;
      });
    }
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              addMediaModel(context);
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: HelperVariabels.fabGradient,
                shape: BoxShape.circle
              ),
              child: Icon(Icons.add),
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: TextField(
              controller: messageController,
              style: TextStyle(
               color: Colors.white 
              ),
              onChanged: (val){
                if(val.length >0  && val.trim().length > 0){
                  setWriting(true);
                } 
                else{
                  setWriting(false);
                }
              },
              decoration: InputDecoration(
                hintText: "Type Message",
                hintStyle: TextStyle(
                  color: HelperVariabels.greyColor
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(50)
                  ),
                  borderSide: BorderSide.none,
                  
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                filled: true,
                fillColor: HelperVariabels.separatorColor,
                suffixIcon: GestureDetector(
                  onTap: (){},
                  child: Icon(Icons.face),
                )
              ),
            ),
          ),
          isWriting?Container(): Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.record_voice_over,
              color: Colors.white,
            ),
          ),
          isWriting? Container():  Icon(Icons.camera_alt,color: Colors.white,),
          
          isWriting ? Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              gradient: HelperVariabels.fabGradient,
              shape: BoxShape.circle,
              
            ),
            child: IconButton(
              icon: Icon(Icons.send, size: 19),

              onPressed: (){},
            ),
          )
          :Container()
        ],
      ),
    );
  }

  CustomAppBar customAppbar(context){
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () =>Navigator.pop(context),

      ),
      centerTile: false,
      title: Text(
        widget.reciver.name
      ),
      actions: [
         IconButton(
           icon: Icon(Icons.video_call),
           onPressed: () {},
         ),
         IconButton(
           icon: Icon(Icons.phone),
           onPressed: (){},
         ),
      
      ],
    );
  }

}


class ModelTile extends StatelessWidget {

  final String title;
  final String subtitle;
  final IconData icon;

  ModelTile({
    Key key, 
    @required this.title, 
    @required this.subtitle, 
    @required this.icon
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomTile(
        mini: false,
        leading: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: HelperVariabels.receiverColor
          ),
          padding: EdgeInsets.all(10),
          child: Icon(
            icon,
            color: HelperVariabels.greyColor,
            size: 38,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: HelperVariabels.greyColor,
            fontSize: 14
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        ),
      ),
    );
  }
}