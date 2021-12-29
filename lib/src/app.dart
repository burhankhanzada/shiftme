import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/constants/color_constants.dart';
import 'package:shiftme/src/models/shiftme_user.dart';
import 'package:shiftme/src/models/transporter.dart';
import 'package:shiftme/src/providers/auth_user_provider.dart';
import 'package:shiftme/src/screens/home/customer_home_screen.dart';
import 'package:shiftme/src/screens/home/transporter_home_screen.dart';
import 'package:shiftme/src/screens/sign_in/enter_number_screen.dart';
import 'package:spaces/spaces.dart';

class App extends StatelessWidget {
  const App({key}) : super(key: key);

  static ShiftMeUser? user;
  static Transporter? transporter;

  @override
  Widget build(context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthUserProvider>(
          create: (context) => AuthUserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => Spacing.fixed(
          data: SpacingData.generate(10),
          child: child!,
        ),
        theme: ThemeData(
          primaryColor: brandPrimaryColor,
          colorScheme: const ColorScheme.light().copyWith(
            primary: brandPrimaryColor,
            onPrimary: Colors.white,
            secondary: brandSecondaryColor,
            onSecondary: Colors.white,
          ),
        ),
        home: Consumer<AuthUserProvider>(
          builder: (context, auth, child) {
            if (!auth.isAuthenticated()) {
              return const LoginScreen();
            } else {
              auth.getUserDataAndNavigateAccordingly(context);
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
