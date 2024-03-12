
import 'package:flash_chat/screenss/login_screen.dart';
import 'package:flash_chat/screenss/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../components/round_botton.dart';

class WelcomeScreen extends StatefulWidget{

  static const String  id = 'welcome_screen';

    @override
    _WelcomeScreenState createState() => _WelcomeScreenState();

}


class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this,
         // upperBound: 100.0
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();

    controller.addListener(() {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Colors.red.withOpacity(animation.value),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget> [
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    // height: 60.0,
                    // height: controller.value,
                    height: animation.value*100,
                    child: Image.asset('images/logo.png'),
                  ),
                ),

                // Container(
                //   // height: 60.0,
                //   height: animation.value*100,
                //   child: Image.asset('images/logo.png'),
                // ),

                // Text('Flash Chat',
                //   style: TextStyle(
                //     color: Colors.black54,
                //     fontSize: 45.0,
                //     fontWeight: FontWeight.w900,
                //   ),
                // ),

                SizedBox(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Flash Chat'),
                      ],
                    ),
                  ),
                ),



              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log in',
              color: Colors.lightBlueAccent,
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              color: Colors.lightBlueAccent,
              onPressed: (){
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }

}

