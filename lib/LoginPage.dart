import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si_lelang/HomePage.dart';
import 'package:si_lelang/LupaPasswordPage.dart';
import 'package:si_lelang/RegisterPage.dart';
import 'package:si_lelang/model/fadeanimation.dart';
import 'package:si_lelang/textfield/textfield.dart';
import 'package:si_lelang/textfield/textfieldpw.dart';
import 'package:si_lelang/database/api.dart';
import 'package:si_lelang/model/user.dart';
import 'package:http/http.dart' as http;

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> with SingleTickerProviderStateMixin{
  
  bool obscurepas = true;
  bool ingatsaya = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();

    // Periksa email saat Loginpage ditampilkan
    SharedPreferences.getInstance().then((prefs) {
      String? rememberedEmail = prefs.getString('rememberedEmail');
      if (rememberedEmail != null && rememberedEmail.isNotEmpty) {
        emailcontroller.text = rememberedEmail;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Colors.white, Color.fromARGB(255, 228, 228, 228)],
              ),
            ),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 115,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeAnimation(
                          duration: const Duration(milliseconds: 1500),
                          child: Container(
                            width: 106,
                            height: 114,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/logo.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 65,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.bold,
                              height: 0,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Rasakan kemudahan lelang bagi siapapun didukung dengan\nproses yang bebas ribet menggunakan Silelang.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.normal,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 390,
                            child: CustomTextField(
                              hintText: 'Masukan E-mail anda',
                              labelText: 'E-mail',
                              prefixIcon: Icons.email_outlined,
                              controller: emailcontroller,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email harus diisi';
                                }
                                if (!GetUtils.isEmail(value)) {
                                  return 'Format email tidak valid';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: 390,
                            child: CustomTextFieldPassword(
                              hintText: 'Masukan Password anda',
                              labelText: 'Password',
                              prefixIcon: Icons.lock_outline,
                              controller: passwordcontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password harus diisi';
                                }
                                if (value.length < 8) {
                                  return 'Password minimal 8 karakter';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: ingatsaya,
                                      onChanged: (value) {
                                        setState(() {
                                          ingatsaya = value!;
                                        });
                                      },
                                      activeColor: const Color(0xFF35755D),
                                    ),
                                    Text(
                                      'Ingat Saya',
                                      style: TextStyle(
                                        fontWeight: ingatsaya
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: ingatsaya
                                            ? Colors.black
                                            : const Color(0xFF606060),
                                        fontSize: 12,
                                        fontFamily: 'Lexend',
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(const LupaPasswordPage());
                                  },
                                  child: const Text(
                                    'Lupa Password',
                                    style: TextStyle(
                                      color: Color(0xFF606060),
                                      fontSize: 12,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w400,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: 390,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  login();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF35755D),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Container(
                                width: 390,
                                height: 60,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Masuk',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 390,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(const RegisterPage());
                                emailcontroller.clear();
                                passwordcontroller.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.white, // Warna latar belakang tombol
                                side: const BorderSide(
                                    width: 1,
                                    color:
                                        Color(0xFF606060)), // Garis tepi tombol
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Container(
                                width: 390,
                                height: 60,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Buat akun',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 16,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text("Atau masuk menggunakan",
                              style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 12,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 40,
                            child: TextButton.icon(
                              onPressed: () {},
                              icon: Image.asset('images/logo_google.png'),
                              label: const Text("Guest",
                                  style: TextStyle(
                                    color: Color(0xFF606060),
                                    fontSize: 12,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //BACKEND BANG

void login() async {
  if (_formKey.currentState!.validate()) {
    String email = emailcontroller.text;
    String password = passwordcontroller.text;

    var response = await http.post(
      Uri.parse(Api.urlLogin),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      // Request successful, parse the response body
      Map<String, dynamic> json = jsonDecode(response.body.toString());
      User user = User.fromMap(json["user"]);

      // Simpan informasi user ke dalam SharedPreferences jika checkbox ingatsaya dicentang
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (ingatsaya) {
        await prefs.setString('rememberedEmail', emailcontroller.text);
      } else {
        await prefs.remove('rememberedEmail');
      }

      // Save user data in shared preferences
      await prefs.setString('nik', user.nik);
      await prefs.setString('nama', user.nama);
      await prefs.setString('jenis_kelamin', user.jenis_kelamin);
      await prefs.setString('tempat_lahir', user.tempat_lahir);
      await prefs.setString('tanggal_lahir', user.tanggal_lahir.toIso8601String());
      await prefs.setString('alamat', user.alamat);
      await prefs.setString('nohp', user.nohp);
      await prefs.setString('foto', base64Encode(user.foto));
      await prefs.setString('email', user.email);


      Get.snackbar(
        'Login Berhasil',
        'Selamat datang, ${user.nama}',
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 2),
        titleText: const Text(
          'Login Berhasil',
          style: TextStyle(fontFamily: 'Lexend', fontSize: 20, color: Color(0xFF35755D)),
        ),
        messageText: Text(
          'Selamat datang, ${user.nama}',
          style: const TextStyle(fontFamily: 'Lexend', fontSize: 16, color: Color(0xFF35755D)),
        ),
      );

      Get.off(const HomePage(), arguments: user);
    } else {
      Get.snackbar(
        'Login Gagal',
        'Email atau password salah',
        backgroundColor: const Color(0xFF35755D),
        overlayBlur: 1,
        duration: const Duration(seconds: 2),
        titleText: const Text(
          'Login Gagal',
          style: TextStyle(fontFamily: 'Lexend', fontSize: 20, color: Colors.white),
        ),
        messageText: const Text(
          'Email atau password salah',
          style: TextStyle(fontFamily: 'Lexend', fontSize: 16, color: Colors.white),
        ),
      );
    }
  }
}


void checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? usernik = prefs.getString('nik') ?? '';
  if (usernik.isNotEmpty) {
    String userName = prefs.getString('nama') ?? '';
        String userKelamin = prefs.getString('jenis_kelamin') ?? '';
        String userTempatLahir = prefs.getString('tempat_lahir') ?? '';
        DateTime userTanggalLahir = DateTime.tryParse(prefs.getString('tanggal_lahir') ?? '') ?? DateTime.now();
        String userAlamat = prefs.getString('alamat') ?? '';
        String userNohp = prefs.getString('nohp') ?? '';
        Uint8List userFoto = base64Decode(prefs.getString('foto') ?? '');
        String userEmail = prefs.getString('email') ?? '';

        User user = User(
          nik: usernik,
          nama: userName,
          jenis_kelamin: userKelamin,
          tempat_lahir: userTempatLahir,
          tanggal_lahir: userTanggalLahir,
          alamat: userAlamat,
          nohp: userNohp,
          foto: userFoto,
          email: userEmail,
        );
    Get.off(const HomePage(), arguments: user);
  }
}

void _logout() async {
  SharedPreferences prefss = await SharedPreferences.getInstance();
  await prefss.remove('nik');
  await prefss.remove('nama');
  Get.offAll(const Loginpage());
}



}
