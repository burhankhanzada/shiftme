import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/app.dart';
import 'package:shiftme/src/models/user.dart';
import 'package:shiftme/src/providers/auth_user_provider.dart';
import 'package:spaces/spaces.dart';

import 'home/home_screen.dart';

class SetupProfile extends StatelessWidget {
  const SetupProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Setup Profile"),
        backgroundColor: Theme.of(context).canvasColor,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SpacedColumn.big(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Align(
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          radius: 56,
                          child: const Icon(
                            Icons.person,
                            size: 96,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () async {
          final firebaseUser = context.read<AuthUserProvider>().firebaseUser!;

          final name = nameController.text;

          await firebaseUser.updateDisplayName(name);

          final uid = firebaseUser.uid;

          App.user = User(
            uid: uid,
            name: nameController.text,
            phoneNumber: firebaseUser.phoneNumber!,
          );

          final users = FirebaseFirestore.instance.collection('users');

          await users.doc(uid).set(App.user!.toMap());

          await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (contex) => const HomeScreen()),
            (route) => false,
          );
        },
      ),
    );
  }
}
