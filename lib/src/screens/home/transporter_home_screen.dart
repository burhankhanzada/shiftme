import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/providers/auth_user_provider.dart';
import 'package:shiftme/src/screens/bookings_screen.dart';
import 'package:shiftme/src/screens/home/drawer.dart';
import 'package:spaces/spaces.dart';

class TransporterHomeScreen extends StatelessWidget {
  const TransporterHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthUserProvider>(
      builder: (context, loginStore, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            foregroundColor: Theme.of(context).colorScheme.primary,
            title: Image.asset(
              'assets/images/brand_logo.png',
              fit: BoxFit.contain,
              height: 30,
            ),
          ),
          drawer: const HomeDrawer(),
          body: const BookingsScreen(),
        );
      },
    );
  }
}
