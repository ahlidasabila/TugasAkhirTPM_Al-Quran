import 'package:finalproject/components/navbar.dart';
import 'package:finalproject/components/palettes.dart';
import 'package:finalproject/pages/login.dart';
import 'package:finalproject/routes/generateroute.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getInt('userId');
  // print(userId);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '123200131 - Final Project TPM',
      theme: ThemeData(
        primarySwatch: Palette.mainColor,
        fontFamily: 'Poppins',
      ),
      home: userId == null ? LoginPage() : NavBar(),
      onGenerateRoute: RouterGenerator.generateRoute,
    ),
  );
}
