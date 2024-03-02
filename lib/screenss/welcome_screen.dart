
import 'package:flash_chat/screenss/login_screen.dart';
import 'package:flash_chat/screenss/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
      print('controller.value =  ${animation.value}');
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
                Container(
                  // height: 60.0,
                  height: animation.value*100,
                  child: Image.asset('images/logo.png'),
                ),
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

                // Hero(
                //   tag: 'logo',
                //   child: Container(
                //     // height: 60.0,
                //     height: controller.value,
                //     child: Image.asset('images/logo.png'),
                //   ),
                // ),

              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: (){
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: (){
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}