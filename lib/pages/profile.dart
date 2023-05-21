import 'dart:async';
import 'package:finalproject/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> listWaktuBagian = <String>['WIB', 'WITA', 'WIT', 'UTC'];
  late String waktuBagian = listWaktuBagian.first;
  late String timeString;
  late Timer timer;
  late SharedPreferences prefs;
  late int _userId;
  String username = "";

  Future<void> _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('userId');
    print(userId);
    setState(() {
      _userId = userId!;
    });
  }

  void getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString('username')!;
    });
  }

  @override
  void initState() {
    super.initState();
    timeString = _formatDateTime(DateTime.now());
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    _userId = 0;
    _getUserId();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  content: const Text('Are you sure want to log out?'),
                  actions: <TextButton>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.remove('userId');
                        pref.remove('username');
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', (route) => false);
                      },
                      child: const Text('Yes',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  timeString,
                  style: const TextStyle(fontSize: 25, fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: DropdownButton<String>(
                  underline: Container(),
                  value: waktuBagian,
                  elevation: 16,
                  onChanged: (String? value) {
                    setState(() {
                      waktuBagian = value!;
                    });
                  },
                  items: listWaktuBagian
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                            fontSize: 25, fontFamily: 'Poppins'),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/profile.jpg')),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              SizedBox(height: 10),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "About Me",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nama"),
                            Text("NIM"),
                            Text("Kelas"),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(": Ahlida Sabila Larasati"),
                            Text(": 123200131"),
                            Text(": TPM-D"),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _getTime() {
    DateTime waktu;
    if (waktuBagian == 'WITA') {
      waktu = DateTime.now().add(const Duration(hours: 1));
    } else if (waktuBagian == 'WIT') {
      waktu = DateTime.now().add(const Duration(hours: 2));
    } else if (waktuBagian == 'UTC') {
      waktu = DateTime.now().toUtc();
    } else {
      waktu = DateTime.now();
    }

    final String formattedDateTime = _formatDateTime(waktu);
    setState(() {
      timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('kk:mm:ss').format(dateTime);
  }

  void setLogout() async {
    final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

    SharedPreferences getPref = await _pref;
    getPref.setBool('isLogin', false);
    getPref.remove('username');
  }
}
