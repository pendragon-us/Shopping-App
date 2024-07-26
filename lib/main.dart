import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppingpos/screens/login/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shopping App",
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
