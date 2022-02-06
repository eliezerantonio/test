import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:produtos/controller/product_controller.dart';
import 'package:produtos/home_page.dart';
import 'package:produtos/login_page.dart';
import 'package:provider/provider.dart';

import 'controller/user_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductController(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => UserController(),
          lazy: false,
          
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
