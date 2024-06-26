import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:si_lelang/LoginPage.dart';
import 'package:si_lelang/database/api.dart';
import 'package:si_lelang/textfield/textfield.dart';
import 'package:si_lelang/textfield/textfieldpw.dart';
import 'package:si_lelang/model/user.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namacontroller = TextEditingController();
  final TextEditingController nikcontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController alamatcontroller = TextEditingController();
  final TextEditingController nowacontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController repasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.00, -1.00),
                  end: Alignment(0, 1),
              colors: [
                Colors.white,
                Color.fromARGB(255, 228, 228, 228),
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 80,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 53,
                        height: 59,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/logo.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40,),
                  const Padding(
                    padding: EdgeInsets.only(left: 21),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Buat Akun",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        SizedBox(height: 4,),
                        Text("Lengkapi data dibawah ini",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                   Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 390,
                          child: CustomTextField(
                            hintText: 'Nama Lengkap Anda',
                            labelText: 'Nama',
                            prefixIcon: Icons.account_circle_outlined,
                            controller: namacontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Nama harus diisi';
                              }
                              if (RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Pastikan format nama benar';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: 390,
                          child: CustomTextField(
                            hintText: 'NIK Anda',
                            labelText: 'NIK',
                            prefixIcon: Icons.assignment_ind_outlined,
                            controller: nikcontroller,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'NIK harus diisi';
                              }
                              if(value.length < 16){
                                return 'NIK harus 16 digit';
                              }
                              if(value.length > 16){
                                return 'NIK harus 16 digit';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: 390,
                          child: CustomTextField(
                            hintText: 'Email Anda',
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
                        const SizedBox(height: 12),
                        Container(
                          width: 390,
                          child: CustomTextField(
                            hintText: 'Alamat Anda',
                            labelText: 'Alamat',
                            prefixIcon: Icons.location_on_outlined,
                            controller: alamatcontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Alamat harus diisi';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: 390,
                          child: CustomTextField(
                            hintText: 'No. Whatsapp Anda',
                            labelText: 'No Whatsapp',
                            prefixIcon: Icons.call_outlined,
                            controller: nowacontroller,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'No Whatsapp harus diisi';
                              }
                              if (value.length < 12){
                                return 'Minimal 12 digit';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: 390,
                          child: CustomTextFieldPassword(
                            hintText: 'Masukan Password',
                            labelText: 'Password',
                            prefixIcon: Icons.lock_outline,
                            controller: passwordcontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password harus diisi';
                              }
                              if (value.length < 8){
                                return 'Password minimal 8 karakter';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: 390,
                          child: CustomTextFieldPassword(
                            hintText: 'Konfirmasi Password',
                            labelText: 'Re Password',
                            prefixIcon: Icons.lock_outline,
                            controller: repasswordcontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Konfirmasi password harus diisi';
                              }
                              if (value != passwordcontroller.text) {
                                return 'Konfirmasi password tidak cocok';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 12,),
                        Container(
                        width: 390,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              register();
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
                              'Buat akun',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                                height: 1,
                              ),
                            ),
                          )
                        )
                        ),
                        const SizedBox(height: 30,)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      )
    );
  }

  void register() async {
    User user = User(
      name: namacontroller.text,
      nik: nikcontroller.text,
      email: emailcontroller.text,
      alamat: alamatcontroller.text,
      nowa: nowacontroller.text,
      password: passwordcontroller.text
      );

      try {
        var userMap = user.toMap();
        var formdata = <String, String>{};
        userMap.forEach((key, value) {
          formdata[key] = value.toString();
        });

        var response = await http.post(Uri.parse(Api.urlRegister), body: formdata);
        if (response.statusCode == 201){
          showAlert(
            response.statusCode.toString(), response.body.toString()
          );
          Get.snackbar(
            'Register Berhasil',
            'Data berhasil ditambahkan',
            backgroundColor: const Color(0xFF35755D),
            titleText: const Text(
              'Register Berhasil',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, fontFamily: 'Lexend', color: Colors.white),
            ),
            messageText: const Text(
              'Data berhasil ditambahkan',
              style: TextStyle(fontSize: 16.0, fontFamily: 'Lexend', color: Colors.white),
            ),
          );
          Get.offAll(const Loginpage());
        } else {
          showAlert(
            response.statusCode.toString(), response.body.toString());
        }
      } catch (a){
        if(a is SocketException){
          showAlert("Error", a.toString());
        }
      }
  }

  Future<void> showAlert(String title, String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

