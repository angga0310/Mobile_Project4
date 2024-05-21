import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si_lelang/Bottom/BottomSheetBid.dart';
import 'package:si_lelang/model/barang.dart';
import 'package:si_lelang/model/user.dart';
import 'package:si_lelang/database/api.dart';

class DetailBarangPage extends StatefulWidget {
  final Barang barang;

  const DetailBarangPage({Key? key, required this.barang}) : super(key: key);

  @override
  State<DetailBarangPage> createState() => _DetailBarangPageState();
}

class _DetailBarangPageState extends State<DetailBarangPage> {
  int _currentIndex = 0;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData().then((user) {
      setState(() {
        currentUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Image> imageList = [
      Image.memory(widget.barang.foto_barang!),
      Image.memory(widget.barang.foto_barang_depan!),
      Image.memory(widget.barang.foto_barang_belakang!),
      Image.memory(widget.barang.foto_barang_kanan!),
      Image.memory(widget.barang.foto_barang_kiri!),
    ];

    bool isUserBarangOwner = currentUser?.nik == widget.barang.nik;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.barang.nama_barang,
          style: TextStyle(
            fontFamily: 'Lexend',
            color: Color(0xFF35755D),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF35755D)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CarouselSlider(
              items: imageList,
              options: CarouselOptions(
                height: 332,
                enlargeCenterPage: true,
                autoPlay: false,
                aspectRatio: 16 / 9,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList.map((url) {
                int index = imageList.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? const Color.fromRGBO(0, 0, 0, 0.9)
                        : const Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deskripsi:',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.barang.deskripsi,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lexend',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Harga: Rp ${widget.barang.harga_barang}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lexend',
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: isUserBarangOwner
                  ? null
                  : () async {
                      if (currentUser != null) {
                        BottomSheetBid bottomSheetBid = BottomSheetBid(
                          context: context,
                          judul: widget.barang.nama_barang,
                          harga_barang: widget.barang.harga_barang,
                          kelipatan: widget.barang.kelipatan, 
                          nik: currentUser!.nik, 
                          id_barang: widget.barang.id_barang,
                        );
                        await bottomSheetBid.show();
                      }
                    },
              child: const Text('Ikuti Lelang / Tawar Barang'),
            ),

            if (currentUser != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'User: ${currentUser!.nama}',
                  style: const TextStyle(fontFamily: 'Lexend', fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<User> _loadUserData() async {
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
      return user;
    } else {
      throw Exception('No user data found in SharedPreferences');
    }
  }
}
