import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si_lelang/database/api.dart';
import 'dart:io';
import 'package:si_lelang/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  File? _image;
  User? currentUser;
  late int idBarang;

  @override
  void initState() {
    super.initState();
    idBarang = Get.arguments['id_barang'];
    _loadUserData().then((user) {
      setState(() {
        currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 300,
                width: double.infinity,
                color: Colors.grey[300],
                child: _image != null
                    ? Image.file(
                        _image!,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              size: 100,
                              color: Colors.grey[700],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Tekan untuk memilih gambar',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _confirmUpload,
              child: Text('Kirim Bukti Pembayaran'),
            ),
          ],
        ),
      ),
    );
  }

Future<User> _loadUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? usernik = prefs.getString('nik');
  if (usernik != null && usernik.isNotEmpty) {
    String userName = prefs.getString('nama') ?? '';
    String userKelamin = prefs.getString('jenis_kelamin') ?? '';
    String userTempatLahir = prefs.getString('tempat_lahir') ?? '';
    DateTime userTanggalLahir =
        DateTime.tryParse(prefs.getString('tanggal_lahir') ?? '') ??
            DateTime.now();
    String userAlamat = prefs.getString('alamat') ?? '';
    String userNohp = prefs.getString('nohp') ?? '';
    String userFoto = prefs.getString('foto') ?? '';
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
    return user;
  } else {
    throw Exception('No user data found in SharedPreferences');
  }
}

  Future<void> uploadPaymentProof(String nik, int idBarang, File imageFile) async {
    var uri = Uri.parse('${Api.urlpembayaran}?nik=$nik&id_barang=$idBarang');

    var request = http.MultipartRequest('POST', uri)
      ..fields['nik'] = nik
      ..fields['id_barang'] = idBarang.toString()
      ..files.add(await http.MultipartFile.fromPath(
        'foto_transfer',
        imageFile.path,
        contentType: MediaType('image', path.extension(imageFile.path).replaceFirst('.', '')),
      ));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Pembayaran berhasil diupload');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bukti pembayaran berhasil diupload'),
        ),
      );
    } else {
      var responseData = await response.stream.bytesToString();
      print('Gagal mengupload pembayaran: ${response.reasonPhrase}');
      print('Response Data: $responseData');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengupload pembayaran: ${response.reasonPhrase}'),
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _confirmUpload() async {
    if (_image != null) {
      bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Apakah Anda yakin file yang dipilih sudah benar?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Ya'),
              ),
            ],
          );
        },
      );

      if (confirm == true) {
        if (currentUser != null) {
          await uploadPaymentProof(currentUser!.nik, idBarang, _image!);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User data tidak ditemukan'),
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap pilih gambar terlebih dahulu'),
        ),
      );
    }
  }
}
