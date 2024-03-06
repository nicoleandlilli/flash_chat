

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
  late User loggedInUser;

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
            Container(
              // decoration: ,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: TextField(
                    onChanged: (value){},
                    // decoration: ,
                  )),
                  // FlatButton(
                  // );

                  TextButton(
                      onPressed: (){},
                      child: Text(
                        'Send',
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