import 'package:finalproject/components/palettes.dart';
import 'package:finalproject/model/user.dart';
import 'package:finalproject/pages/login.dart';
import 'package:finalproject/service/user_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String error = "";

  late UserModel _currentUser;

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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Sorry, we're working on getting this fixed ASAP"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                        color: Color(0xff8B0000),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            MaterialButton(
              onPressed: () async {
                if (_usernameController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text("Please fill all fields"),
                          ),
                        );
                      });
                  return;
                }

                UserModel user = UserModel(
                    username: _usernameController.text,
                    password: _passwordController.text);
                try {
                  await userDatabaseHelper.createUser(user);
                } catch (e) {
                  setState(() {
                    error = e.toString();
                  });
                  return;
                }
                setState(() {
                  error = "User Created";
                });
              },
              height: 45,
              color: Palette.mainColor,
              child: Text(
                "Register",
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
                Text("Have an account?",
                    style: TextStyle(color: Palette.mainColor)),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text('Login', style: TextStyle(color: Colors.black)),
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
