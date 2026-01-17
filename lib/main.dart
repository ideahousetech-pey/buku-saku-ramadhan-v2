import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_siswa_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Saku Ramadhan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/login-siswa': (context) => const LoginSiswaPage(),
      },
    );
  }
}
