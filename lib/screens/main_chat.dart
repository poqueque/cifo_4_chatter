import 'dart:io';

import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chatter/extensions/date_extensions.dart';
import 'package:chatter/screens/splash.dart';
import 'package:chatter/services/database_provider.dart';
import 'package:chatter/styles/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MainChat extends StatefulWidget {
  const MainChat({super.key});

  @override
  State<MainChat> createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  TextEditingController controller = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.spaceCadet,
        foregroundColor: AppStyles.magnolia,
        title: Text("Chatter"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(FirebaseAuth
                        .instance.currentUser?.photoURL ??
                    "https://static.thenounproject.com/png/5034901-200.png"),
              ),
              accountName:
                  Text(FirebaseAuth.instance.currentUser?.displayName ?? "---"),
              accountEmail:
                  Text(FirebaseAuth.instance.currentUser?.email ?? "---"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Canviar nom d'usuari"),
              onTap: changeUserName,
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Canviar imatge de perfil"),
              onTap: changeProfilePicture,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Tancar sessió"),
              onTap: logout,
            ),
          ],
        ),
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
                    Column(
                      children: [
                        if (!message.isMine)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                message.userName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                        BubbleSpecialOne(
                          text: message.content,
                          isSender: message.isMine,
                          color: message.isMine
                              ? AppStyles.aero
                              : AppStyles.magnolia,
                        ),
                        Align(
                            alignment: message.isMine
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(message.dateTime.formatHHMM()),
                            )),
                      ],
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
    controller.text = "";
  }

  void changeUserName() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Nom d'usuari"),
          content: TextField(
            autofocus: true,
            controller: nameController,
            decoration:
                InputDecoration(hintText: "Introdueix el teu nom d'usuari"),
          ),
          actions: [
            TextButton(
              onPressed: saveUserName,
              child: Text("GUARDAR"),
            )
          ],
        );
      },
    );
  }

  Future<void> saveUserName() async {
    String displayName = nameController.text;
    await FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
    if (!mounted) return;
    Navigator.pop(context);
    setState(() {});
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Splash()));
  }

  Future<void> changeProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef
          .child('users')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child('profile.png');
      File fileToUpload = File(image.path);
      await imageRef.putFile(fileToUpload);
      String url = await imageRef.getDownloadURL();
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
      setState(() {});
    }
  }
}
