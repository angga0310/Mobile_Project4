import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:si_lelang/textfield/textfield.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _LupaPasswordPageState();
}

class _LupaPasswordPageState extends State<OTPPage> {
  final TextEditingController wacontrroller = TextEditingController();
  final TextEditingController nowacontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      const Text("Masukan Kode OTP",
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
                          hintText: 'Kode OTP yang diterima',
                          labelText: 'Kode OTP',
                          prefixIcon: Icons.keyboard_control_outlined,                            
                          controller: nowacontroller,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Kode OTP harus diisi';
                            }
                            if (value.length < 6){
                              return 'Minimal 6 digit';
                            }
                            return null;
                          },
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            const Text("Tidak menerima kode OTP?",
                              style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 12,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w400,
                                )
                            ),
                            TextButton(onPressed: () {
                         
                            },
                            child: const Text('Kirim ulang kode',
                              style: TextStyle(
                                color: Color(0xFF427CC1),
                                fontSize: 12,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w400,
                                height: 1,)
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        width: 390,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            
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
                              'Lanjutkan',
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}