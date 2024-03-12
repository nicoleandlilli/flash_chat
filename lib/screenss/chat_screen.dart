import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
final _firebaseStore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {

  static const String  id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen>{
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try{
      final User? user = await _auth.currentUser;
      if(user != null){
        loggedInUser = user;
        print('logged In User email is : ${loggedInUser.email}');
      }
    }catch(e){
      print(e);
    }
  }

  void getMessages() async {
    // Future<QuerySnapshot<T>>
    final messages = await _firebaseStore.collection('messages').get();
    for(var message in messages.docs){
      print(message.data());
    }
  }
  
  void getStreamMessages() async {
    await for(var snapshot in _firebaseStore.collection('messages').snapshots()){
      for(var message in snapshot.docs){
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(onPressed: (){
            _auth.signOut();
            Navigator.pop(context);
          }, icon: Icon(Icons.close)),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              // decoration: ,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: TextField(
                    controller: messageTextController,
                    onChanged: (value){
                      messageText = value;
                    },
                    style: TextStyle(
                        color: Colors.black
                    ),
                    // decoration: ,
                  )),
                  // FlatButton(
                  // );

                  TextButton(
                      onPressed: (){
                        messageTextController.clear();
                        _firebaseStore.collection('messages').add({
                          'msg':messageText,
                          'sender': loggedInUser.email,
                        });
                      },
                      child: Text(
                        'Send',
                        // style: ,
                      ),
                  ),


                  // TextButton(
                  //   onPressed: ()  {
                  //     getMessages();
                  //   },
                  //   child: Text(
                  //     'Get',
                  //     // style: ,
                  //   ),
                  // ),


                  // TextButton(
                  //   onPressed: ()  {
                  //     getStreamMessages();
                  //   },
                  //   child: Text(
                  //     'Stream Get',
                  //
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class MessageStream extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // Stream<QuerySnapshot<T>> snapshots
      stream: _firebaseStore.collection('messages').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        if(snapshot.hasData){

          List<MessageBubble> messageBubbles = [];

          if(snapshot.data != null ){
            // // List<QueryDocumentSnapshot<T>>
            List<DocumentSnapshot> documents = snapshot.data!.docs;

            for(var document in documents){
              final messageMsg = document['msg'];
              final messageSender = document['sender'];
              print('msg..........$messageMsg');
              print('sender..........$messageSender');

              final messageBubble = MessageBubble(sender: messageSender,text: messageMsg,);
              messageBubbles.add(messageBubble);
            }
          }

          return Expanded(
              child: ListView(
                children: messageBubbles,
              )
          );

        }else{
          print('snapshot.has no Data.................. ');
          List<Text> messageWidgets = [];
          messageWidgets.add(Text('No Data',style: TextStyle(color: Colors.black),));
          return Column(
            children: messageWidgets,
          );
        }
      },

    );
  }

}

class MessageBubble extends StatelessWidget {

  MessageBubble({required this.sender,required this.text});

  final String sender;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              sender,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black54
              ),
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.lightBlueAccent,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  '$text',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
    );
      

  }

}