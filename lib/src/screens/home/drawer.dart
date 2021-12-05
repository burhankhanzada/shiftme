import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/app.dart';
import 'package:shiftme/src/models/user.dart';
import 'package:shiftme/src/providers/auth_user_provider.dart';
import 'package:shiftme/src/screens/bookings_screen.dart';
import 'package:shiftme/src/screens/profile/customer_profile.dart';
import 'package:shiftme/src/screens/profile/transporter_profile.dart';
import 'package:spaces/spaces.dart';

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
                    App.user!.name,
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
                    builder: (context) {
                      if (App.user!.type == UserType.transporter) {
                        return const TransporterProfileScreen();
                      }
                      return const CustomerProfileScreen();
                    },
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
                context.read<AuthUserProvider>().signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
