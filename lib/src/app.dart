import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/constants/color_constants.dart';
import 'package:shiftme/src/providers/auth_user_provider.dart';
import 'package:shiftme/src/screens/home/home_screen.dart';
import 'package:shiftme/src/screens/sign_in/enter_number_screen.dart';
import 'package:spaces/spaces.dart';

import 'models/user.dart';

class App extends StatelessWidget {
  const App({key}) : super(key: key);

  static late User user;

  @override
  build(context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthUserProvider>(
          create: (context) => AuthUserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => Spacing.fixed(
          data: SpacingData.generate(10.0),
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
            if (auth.isAuthenticated()) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
