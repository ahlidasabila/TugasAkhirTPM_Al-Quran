import 'package:finalproject/components/navbar.dart';
import 'package:finalproject/components/palettes.dart';
import 'package:finalproject/pages/register.dart';
import 'package:finalproject/service/user_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 350,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/cover.png',
                      height: 400,
                    ),
                  ),
                ],
              ),
            ),
            _usernameField(),
            SizedBox(height: 20),
            _passwordField(),
            SizedBox(height: 30),
            MaterialButton(
              onPressed: () async {
                try {
                  var listUser =
                      await userDatabaseHelper.getUserByUsernameAndPassword(
                          _usernameController.text, _passwordController.text);
                  if (listUser.length > 0) {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setString('username', listUser[0].username!);
                    pref.setInt('userId', listUser[0].id!);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NavBar()));
                  }
                } catch (e) {
                  setState(() {
                    error = 'Username or Password is wrong';
                  });
                }
              },
              height: 45,
              color: Palette.mainColor,
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                    style: TextStyle(color: Palette.mainColor)),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child:
                      Text('Register', style: TextStyle(color: Colors.black)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _usernameField() {
    return TextField(
      controller: _usernameController,
      cursorColor: Palette.mainColor,
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'username',
        labelStyle: TextStyle(
          color: Palette.mainColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: TextStyle(
          color: Palette.mainColor,
          fontSize: 14.0,
        ),
        prefixIcon: Icon(
          Iconsax.user,
          color: Palette.mainColor,
          size: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.mainColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: TextStyle(
          color: Palette.mainColor,
          fontSize: 18.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.mainColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      obscureText: true,
      controller: _passwordController,
      cursorColor: Palette.mainColor,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'password',
        labelStyle: TextStyle(
          color: Palette.mainColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: TextStyle(
          color: Palette.mainColor,
          fontSize: 14.0,
        ),
        prefixIcon: Icon(
          Iconsax.lock,
          color: Palette.mainColor,
          size: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.mainColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: TextStyle(
          color: Palette.mainColor,
          fontSize: 18.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.mainColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
