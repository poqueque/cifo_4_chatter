import 'package:chatter/screens/splash.dart';
import 'package:chatter/services/database_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainChat extends StatefulWidget {
  const MainChat({super.key});

  @override
  State<MainChat> createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatter"),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Splash()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Consumer<DatabaseProvider>(
                builder: (context, databaseProvider, child) {
              return Expanded(
                child: ListView(reverse: true, children: [
                  for (var message in databaseProvider.messages.reversed)
                    ListTile(
                      title: Text(message.content),
                      subtitle: Text(message.uid.substring(0, 4)),
                      trailing: Text(message.dateTime.toString()),
                    )
                ]),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                onSubmitted: sendMessage,
                decoration: InputDecoration(
                  hintText: "Escriu un missatge",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () => sendMessage(controller.text),
                    icon: Icon(Icons.send),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void sendMessage(String value) {
    context.read<DatabaseProvider>().addMessage(value);
  }
}
