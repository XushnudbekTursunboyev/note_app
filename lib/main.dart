import 'package:flutter/material.dart';
import 'package:note_app/app/data/sources/locale/hive_helper.dart';
import 'package:note_app/app/di/di.dart';
import 'package:note_app/app/presentation/screens/add/add_screen.dart';
import 'package:note_app/app/presentation/screens/main/main_screen.dart';
import 'package:note_app/app/presentation/screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/main': (context) => const MainScreen(),
        '/add': (context) => const AddScreen()
      },
    );
  }
}
