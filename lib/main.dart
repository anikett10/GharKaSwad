import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../home.dart'; // Import your Home screen widget
import '../login.dart'; // Import your Login screen widget
import '../register.dart'; // Import your Register screen widget
import '../constants.dart';
import '../screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Biofit",
        colorScheme: ColorScheme.fromSeed(seedColor: kprimaryColor),
        scaffoldBackgroundColor: kbackgroundColor,
        useMaterial3: true,
      ),
      initialRoute: '/login', // Set initial route to login
      routes: {
        '/home': (context) => MainScreen(), // Define route for home screen
        '/login': (context) => Login(),
        '/register': (context) => Register(),
      },
    );
  }
}
