import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/providers/auth_provider.dart';
import 'package:spaces/spaces.dart';

import '../bookings_screen.dart';
import '../profile_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({key}) : super(key: key);

  @override
  build(context) {
    final textColor = Theme.of(context).colorScheme.primary;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SpacedRow.semiBig(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: const Icon(
                      Icons.person,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "User Name",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: textColor,
                        ),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text("Profile", style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Bookings", style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Log out", style: TextStyle(color: textColor)),
              onTap: () {
                context.read<AuthProvider>().signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
