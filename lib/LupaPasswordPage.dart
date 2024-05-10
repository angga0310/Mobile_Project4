import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:si_lelang/KonfirmasiOTPPage.dart';
import 'package:si_lelang/textfield/textfield.dart';
import 'package:get/get.dart';

class LupaPasswordPage extends StatefulWidget {
  const LupaPasswordPage({super.key});

  @override
  State<LupaPasswordPage> createState() => _LupaPasswordPageState();
}

class _LupaPasswordPageState extends State<LupaPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nowacontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
        child:  Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                 Padding(
                  padding: const EdgeInsets.only(left: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Lupa Password",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 4,),
                      const Text("Masukan nomor Whatsapp",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 28,),
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
                      const SizedBox(height: 30,),
                      Container(
                        width: 390,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              nowacontroller.clear();
                              Get.to(const OTPPage());
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
                              'Kirim Kode OTP',
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
                      Padding(
                        padding: const EdgeInsets.only(left: 84),
                        child: TextButton.icon(
                          onPressed: () {
                            nowacontroller.clear();
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF606060), size: 16,),
                          label: const Text('Kembali ke halaman Login',
                            style: TextStyle(
                              color: Color(0xFF606060),
                              fontSize: 12,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                              height: 1,)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
    );
  }
}