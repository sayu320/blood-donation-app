import 'package:blood_donation/firebase_options.dart';
import 'package:blood_donation/project1/home.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

  Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  }catch(e){
    print('Error initializing Firebase:$e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        
      ),
    home: const HomePage(),
    );
  }
}

