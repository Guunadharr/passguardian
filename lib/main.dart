// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:passguardian/presentation/screens/enterpin.dart';

import 'package:passguardian/presentation/screens/setuppin.dart';
import 'package:passguardian/utils/shared_preferences.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      // systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(milliseconds: 2000));
  FlutterNativeSplash.remove();
  bool isPinSetup = await SharedPreferencesUtil.isPinSetup();
  runApp(MyApp(
    initialRoute: isPinSetup ? '/enterPin' : '/setupPin',
  ));
}

class MyApp extends StatefulWidget {
  final String initialRoute;
  const MyApp({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PassGuardian',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 0, 76, 137)),
          useMaterial3: true),
      initialRoute: widget.initialRoute,
      routes: {
        '/setupPin': (context) => SetupPin(),
        '/enterPin': (context) => EnterPin(),
      },
    );
  }
}
