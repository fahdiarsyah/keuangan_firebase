import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keuangan_firebase/LoginPage.dart';
import 'package:keuangan_firebase/RegisterPage.dart';
import 'package:keuangan_firebase/firebase_options.dart';
import 'package:keuangan_firebase/pages/AddTransaction.dart';
import 'package:keuangan_firebase/pages/dashboard/category_page.dart';
import 'package:keuangan_firebase/pages/dashboard/DashboardPage.dart';
import 'package:keuangan_firebase/models/SplashPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(MaterialApp(
    title: 'Laporan Keuangan',
    initialRoute: '/',
    routes: {
      '/': (context) => const SplashPage(), 
      '/login': (context) => const LoginPage(),
      '/register': (context) => const RegisterPage(),
      '/dashboard': (context) => const DashboardPage(),
      '/category': (context) => const CategoryPage(),
      '/add': (context) => const AddTransaction(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}