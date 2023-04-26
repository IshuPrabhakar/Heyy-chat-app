import 'package:flutter/material.dart';
import 'package:social/screens/welcome/welcome_screen.dart';
import 'package:social/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data_access/objectbox.dart';
import 'entities/user_entity.dart';
import 'screens/screens.dart';

// objectbox
late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

late User? admin = objectbox.user.get(1);
late int? isUserLoggedIn = admin != null ? admin!.isLoggedIn : 0;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hey',
      theme: AppTheme.light(),
      darkTheme: AppTheme
          .dark(), // if thememode is not specified it will follow system theme
      debugShowCheckedModeBanner: false,
      home: isUserLoggedIn == 1 ? HomeScreen() : WelcomeScreen(),
    );
  }
}
