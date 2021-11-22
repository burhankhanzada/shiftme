import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/constants/color_constants.dart';
import 'package:shiftme/src/providers/auth_provider.dart';
import 'package:shiftme/src/screens/home/home_screen.dart';
import 'package:shiftme/src/screens/login_screen.dart';
import 'package:spaces/spaces.dart';

class App extends StatelessWidget {
  const App({key}) : super(key: key);

  @override
  build(context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        )
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
        home: Consumer<AuthProvider>(
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
