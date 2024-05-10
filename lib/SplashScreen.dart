import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si_lelang/HomePage.dart';
import 'package:si_lelang/LoginPage.dart';
import 'package:si_lelang/model/fadeanimation.dart';
import 'package:si_lelang/model/user.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('id');
      if (userId != null) {
        String userName = prefs.getString('name') ?? '';
        User user = User(id: userId, name: userName, nik: '', email: '', alamat: '', nowa: '');
        // Kirim informasi user sebagai arguments
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(),
            settings: RouteSettings(arguments: user),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Loginpage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeAnimation(
          duration: const Duration(seconds: 2),
          child: Container(
            width: 106,
            height: 114,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/logo.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
