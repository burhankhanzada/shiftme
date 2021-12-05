import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftme/src/constants/color_constants.dart';
import 'package:shiftme/src/models/transporter.dart';
import 'package:shiftme/src/models/user.dart';
import 'package:shiftme/src/providers/auth_user_provider.dart';
import 'package:shiftme/src/screens/home/home_screen.dart';
import 'package:shiftme/src/screens/sign_in/enter_number_screen.dart';
import 'package:shiftme/src/utils/firbase.dart';
import 'package:spaces/spaces.dart';

class App extends StatelessWidget {
  const App({key}) : super(key: key);

  static User? user;
  static Transporter? transporter;

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
              final uid = auth.firebaseUser!.uid;

              usersRef.doc(uid).get().then(
                (value) {
                  if (value.exists) {
                    App.user = value.data()!;

                    if (user!.type == UserType.transporter) {
                      transportersRef.doc(uid).get().then(
                        (value) {
                          transporter = value.data()!;
                        },
                      );
                    }

                    return const HomeScreen();
                  }
                },
              );

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
