import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si_lelang/LoginPage.dart';
import 'package:si_lelang/model/barang.dart';
import 'package:si_lelang/model/barangcard.dart';
import 'package:si_lelang/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:si_lelang/database/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<dynamic> users = [];
  List<dynamic> barangs = [];
  String namaUser = '';
  final TextEditingController _searchController = TextEditingController();


  Future<void> _onItemTapped(int index) async {
    if (index == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userLevel = prefs.getInt('level') ?? 1;
      if (userLevel == 2) {
        setState(() {
          _selectedIndex = index;
        });
      } else {
        // Tampilkan pesan akses ditolak dengan penundaan
        Future.delayed(Duration.zero, () {
          Get.snackbar(
            'Akses Ditolak',
            'Anda tidak memiliki izin untuk mengakses halaman ini',
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
            titleText: const Text(
              'Akses Ditolak',
              style: TextStyle(
                  fontFamily: 'Lexend', fontSize: 20, color: Colors.white),
            ),
            messageText: const Text(
              'Anda tidak memiliki izin untuk mengakses halaman ini',
              style: TextStyle(
                  fontFamily: 'Lexend', fontSize: 16, color: Colors.white),
            ),
          );
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Get.put(BarangController()).fetchData();
    _getBarang();
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Halaman 1
          SingleChildScrollView(
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 332,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/bg_home.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      children: [
                        const Positioned(
                          left: 20,
                          top: 52,
                          child: Text(
                            "Selamat Datang,",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 72,
                          child: Text(
                            user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 362,
                          top: 60,
                          child: Container(
                            height: 46,
                            width: 46,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFD9D9D9)),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_outline),
                              color: const Color(0xFF35755D),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 130,
                          child: Container(
                            width: 390,
                            height: 60,
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Cari barang lelang',
                                hintStyle: const TextStyle(
                                  color: Color(0xFF606060),
                                  fontSize: 15,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _cariBarang(_searchController.text);
                                  },
                                  icon: const Icon(Icons.search),
                                ),
                                iconColor: const Color(0xFF1E1E1E),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 20,
                          top: 210,
                          child: Text(
                            'Kategori',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 245,
                          child: Container(
                            height: 29,
                            width: MediaQuery.of(context).size.width - 40,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFD291),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Elektronik',
                                    style: TextStyle(
                                      color: Color(0xFF1E1E1E),
                                      fontSize: 13,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFD291),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Aksesoris',
                                    style: TextStyle(
                                      color: Color(0xFF1E1E1E),
                                      fontSize: 13,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFD291),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Gadget',
                                    style: TextStyle(
                                      color: Color(0xFF1E1E1E),
                                      fontSize: 13,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFD291),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Hobi & Koleksi',
                                    style: TextStyle(
                                      color: Color(0xFF1E1E1E),
                                      fontSize: 13,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 380,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 10,
                        childAspectRatio: 187 / 270,
                      ),
                      itemCount: barangs.length,
                      itemBuilder: (context, index) {
                        var barang = barangs[index];
                        return BarangCard(
                          foto: barang.foto,
                          nama: barang.nama,
                          deskripsi: barang.deskripsi,
                          harga: barang.harga,
                          barang: barang,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Halaman 2
          Center(
            child: ElevatedButton(
                onPressed: () {
                  _logout();
                },
                child: const Text('Logout')),
          ),

          // Halaman 3
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 332,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/bg_home.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Halaman 4
          ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: Text('Nama: ${user.name}'),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text('Email: ${user.email}'),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text('Nomor Telepon: ${user.nowa}'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan aksi untuk mengedit profil
              },
              child: const Text('Edit Profil'),
            ),
            ElevatedButton(
              onPressed: () {
                _logout();
              },
              child: const Text('Logout'),
            ),
          ],
        )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv_outlined),
            label: 'Live Auction',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: 'History',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF35755D),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  void _logout() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Konfirmasi Logout',
          style: TextStyle(
              fontFamily: 'Lexend', fontSize: 20, color: Colors.white),
        ),
        content: const Text(
          'Apakah Anda Yakin Ingin Logout?',
          style: TextStyle(
              fontFamily: 'Lexend', fontSize: 16, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF35755D),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Batal',
                style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 14,
                    color: Color(0xFF35755D))),
          ),
          ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('id'); // Menghapus data id dari SharedPreferences
              prefs
                  .remove('name'); // Menghapus data name dari SharedPreferences
              await Future.delayed(const Duration(
                  milliseconds: 500)); // Menunda navigasi selama 500 milidetik
              Get.offAll(const Loginpage());
            },
            child: const Text('Iya',
                style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 14,
                    color: Color(0xFF35755D))),
          ),
        ],
      ),
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: false,
    );
  }

void _getBarang() async {
    var response = await http.get(Uri.parse(Api.urlgetbarang));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];

      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> barangMap = data[i];

        Uint8List? foto = base64Decode(barangMap['foto']);
        Barang barang = Barang(
          id: barangMap['id'],
          nama: barangMap['nama'],
          deskripsi: barangMap['deskripsi'],
          harga: barangMap['harga'],
          foto: foto,
        );
        setState(() {
          barangs.add(barang);
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

void _cariBarang(String keyword) {
  List<dynamic> filteredBarangs = [];

  if (keyword.isEmpty) {
    setState(() {
      filteredBarangs.addAll(barangs);
    });
  } else {
    barangs.forEach((barang) {
      if (barang.nama.toLowerCase().contains(keyword.toLowerCase())) {
        filteredBarangs.add(barang);
      }
    });
  }

  setState(() {
    barangs = filteredBarangs;
  });
}


}
