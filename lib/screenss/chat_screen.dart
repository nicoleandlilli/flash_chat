

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {

  static const String  id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen>{
  final _auth = FirebaseAuth.instance;
  final _firebaseStore = FirebaseFirestore.instance;
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
            // StreamBuilder<QuerySnapshot>(
            //     stream: _firebaseStore.collection('messages').snapshots(),
                // builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                //   final messages = snapshot.data.docs;
                //   // List<Text> messageWidgets = [];
                //   // for(var message in messages){
                //   //   final messageText = message.data('msg');
                //   //   final messageSender = message.data();
                //   //
                //   //   final messageWidget = Text('$messageText from $');
                //   // }
                //   return Text(''),
                // },

            // ),
            Container(
              // decoration: ,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: TextField(
                    onChanged: (value){
                      messageText = value;
                    },
                    // decoration: ,
                  )),
                  // FlatButton(
                  // );

                  TextButton(
                      onPressed: (){
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


                  TextButton(
                    onPressed: ()  {
                      getMessages();
                    },
                    child: Text(
                      'Get',
                      // style: ,
                    ),
                  ),


                  TextButton(
                    onPressed: ()  {
                      getStreamMessages();
                    },
                    child: Text(
                      'Stream Get',
                      // style: ,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }



}