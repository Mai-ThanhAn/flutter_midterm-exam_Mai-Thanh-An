import 'package:flutter/material.dart';
import 'package:midterm_exam/exercises/ex1_listview/contact_list.dart';
import 'package:midterm_exam/exercises/ex2_gridview/gallery_screen.dart';
import 'package:midterm_exam/exercises/ex3_shared_pref/user_profile.dart';
import 'package:midterm_exam/exercises/ex4_async/loading_screen.dart';
import 'package:midterm_exam/exercises/ex5_isolate/factorial_screen.dart';
import 'package:midterm_exam/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Midterm Test',
      theme: ThemeData(
        fontFamily: 'Hoasen',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
      routes: {
        '/ex1': (context) => const ContactListScreen(),
        '/ex2': (context) => const GalleryScreen(),
        '/ex3': (context) => const UserProfileScreen(),
        '/ex4': (context) => const LoadingScreen(),
        '/ex5': (context) => const FactorialScreen(),
      },
    );
  }
}