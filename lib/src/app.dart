import 'package:flutter/material.dart';
import 'package:shiftme/src/screens/home_screen.dart';
import 'package:spaces/spaces.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Spacing.fixed(
        data: SpacingData.generate(10.0),
        child: child!,
      ),
      theme: ThemeData(
        primaryColor: Colors.orange,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.orange,
          secondary: Colors.brown,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
