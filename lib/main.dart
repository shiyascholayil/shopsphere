import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopsphere/const.dart';
import 'package:shopsphere/provider/auth_provider.dart';
import 'package:shopsphere/screens/login_screen.dart';
import 'package:shopsphere/screens/main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final auth=ref.watch(authProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: auth.isAuthenticated
          ? const MainScreen()
          : const LoginScreen(),
    );
      

  }
}




