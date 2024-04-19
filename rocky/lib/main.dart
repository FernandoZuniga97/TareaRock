import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rocky/firebase_options.dart';
import 'package:rocky/home.dart';
import 'package:rocky/new_users_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // initialRoute: '/login',
      routes: {
        '/new_user': (context) => NewUserPage(),
        '/home': (context) => const MyHomePage(
              title: 'Usuarios desde firebase',
            ),
      },
    );
  }
}