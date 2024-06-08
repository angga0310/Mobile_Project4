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
      String? usernik = prefs.getString('nik') ?? '';
      if (usernik.isNotEmpty) {
        String userName = prefs.getString('nama') ?? '';
        String userKelamin = prefs.getString('jenis_kelamin') ?? '';
        String userTempatLahir = prefs.getString('tempat_lahir') ?? '';
        DateTime userTanggalLahir =
            DateTime.tryParse(prefs.getString('tanggal_lahir') ?? '') ??
                DateTime.now();
        String userAlamat = prefs.getString('alamat') ?? '';
        String userNohp = prefs.getString('nohp') ?? '';
        String userFotoPath = prefs.getString('foto') ??
            ''; // Mengambil path file foto dari SharedPreferences
        String userEmail = prefs.getString('email') ?? '';

        User user = User(
          nik: usernik,
          nama: userName,
          jenis_kelamin: userKelamin,
          tempat_lahir: userTempatLahir,
          tanggal_lahir: userTanggalLahir,
          alamat: userAlamat,
          nohp: userNohp,
          foto: userFotoPath, // Menggunakan path file foto
          email: userEmail,
        );

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
