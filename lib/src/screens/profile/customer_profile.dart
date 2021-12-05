import 'package:flutter/material.dart';
import 'package:shiftme/src/app.dart';
import 'package:shiftme/src/screens/become_tranporter_screen.dart';
import 'package:spaces/spaces.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({key}) : super(key: key);

  @override
  build(context) {
    final user = App.user!;

    final uid = user.uid!;

    final name = user.name;

    final number = user.phoneNumber;

    final type = user.type;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Customer Profile"),
        backgroundColor: Theme.of(context).canvasColor,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SpacedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          radius: 56,
                          child: const Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        number,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              child: const Text("Become Tranporter"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BecomeTransporterScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
