import 'package:chatter/screens/main_chat.dart';
import 'package:chatter/styles/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String status = "Carregant dades...";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, init);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat,
            size: 48,
            color: AppStyles.spaceCadet,
          ),
          SizedBox(
            height: 24,
          ),
          Text(status),
        ],
      ),
    ));
  }

  Future<void> init() async {
    
    final providers = [EmailAuthProvider()];
    if (FirebaseAuth.instance.currentUser == null) {
      //Show login
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SignInScreen(
                    providers: providers,
                    actions: [
                      AuthStateChangeAction<UserCreated>((context, state) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainChat()));
                      }),
                      AuthStateChangeAction<SignedIn>((context, state) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainChat()));
                      }),
                    ],
                  )));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainChat()));
    }
  }
}
