import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screenss/chat_screen.dart';
import 'package:flash_chat/screenss/login_screen.dart';
import 'package:flash_chat/screenss/registration_screen.dart';
import 'package:flash_chat/screenss/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      title: 'Flash Chat',
      theme: ThemeData.dark().copyWith(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
      ),
      // home: WelcomeScreen(),
      // initialRoute: 'welcome_screen',
      //
      // routes: {
      //   'welcome_screen':(context) => WelcomeScreen(),
      //   'login_screen':(context) => LoginScreen(),
      //   'registration_screen':(context) => RegistrationScreen(),
      //   'chat_screen':(context) => ChatScreen(),
      // },

      initialRoute: WelcomeScreen.id,

      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
