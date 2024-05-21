import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:si_lelang/LoginPage.dart';
import 'package:si_lelang/FavoritePage.dart';
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
  List<dynamic> barangs = [];
  bool isLoading = true;
  late User currentUser;
  String namaUser = '';
  final TextEditingController _searchController = TextEditingController();


Future<void> _onItemTapped(int index) async {
  setState(() {
    _selectedIndex = index;
    if (_selectedIndex == 0){
      _getBarang();
    } else if(_selectedIndex == 1){
      _getOpenBarang();
    }
    barangs.clear();
  });
}

@override
void initState() {
  super.initState();
  _loadUserData().then((user) {
    setState(() {
      currentUser = user;
    });
    _getBarang();
  });
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
                            user.nama.split(' ').take(2).join(' '),
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
                              onPressed: () {
                                // Get.to(FavoritePage)
                              },
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
                                    // _cariBarang(_searchController.text);
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
                          foto_barang: barang.foto_barang,
                          nama: barang.nama_barang,
                          deskripsi: barang.deskripsi,
                          harga_barang: barang.harga_barang,
                          barang: barang
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Halaman 2
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
                foto_barang: barang.foto_barang,
                nama: barang.nama_barang,
                deskripsi: barang.deskripsi,
                harga_barang: barang.harga_barang,
                          barang: barang
              );
            },
            ),
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
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.00, -1.00),
              end: Alignment(0, 4),
              colors: [Colors.white, Color(0xFFDDDDDD)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 32),
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: Color(0xFF35755D),
                    fontSize: 24,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 54),
                child: Center(
                  child: Container(
                    width: 81,
                    height: 81,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF80C4B3),
                      shape: OvalBorder(),
                    ),
                    child: Center(
                      child: Text(
                        user.nama.substring(0, 1),
                        style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Center(
                  child: Text(
                    user.nama,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Center(
                  child: Text(
                    user.jenis_kelamin,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
              Center(
              child: Container(
                width: 390,
                height: 60,
                decoration: ShapeDecoration(
                  color: Color(0xFFC4C4C4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0), // Adjust padding as needed
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.email_outlined, // Replace with the desired icon
                          color: Color(0xFF606060),
                        ),
                        SizedBox(width: 12), // Space between icon and text
                        Text(
                        user.email,
                        style: const TextStyle(
                          color: Color(0xFF606060),
                          fontSize: 15,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12,),
            Center(
              child: Container(
                width: 390,
                height: 60,
                decoration: ShapeDecoration(
                  color: Color(0xFFC4C4C4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0), // Adjust padding as needed
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined, // Replace with the desired icon
                          color: Color(0xFF606060),
                        ),
                        SizedBox(width: 12), // Space between icon and text
                        Text(
                        user.tanggal_lahir.toString().substring(0, 10),
                        style: const TextStyle(
                          color: Color(0xFF606060),
                          fontSize: 15,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12,),
            Center(
              child: Container(
                width: 390,
                height: 60,
                decoration: ShapeDecoration(
                  color: Color(0xFFC4C4C4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0), // Adjust padding as needed
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.call_outlined, // Replace with the desired icon
                          color: Color(0xFF606060),
                        ),
                        SizedBox(width: 12), // Space between icon and text
                        Text(
                        user.nohp,
                        style: const TextStyle(
                          color: Color(0xFF606060),
                          fontSize: 15,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 44,),
            Center(
              child: ElevatedButton(
              onPressed: () {
                _logout();
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 0.50, color: Color(0xFF606060)),
                  ),
                ),
                child: Ink(
                  width: 390,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Color(0xFFFF0000),
                            fontSize: 15,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                        SizedBox(width: 12,),
                        Icon(Icons.logout_outlined,
                        color: Color(0xFFFF0000),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ],
          ),
        )
      ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
              prefs.remove('nik'); // Menghapus data id dari SharedPreferences
              prefs.remove('nama'); // Menghapus data name dari SharedPreferences
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

      Uint8List? decodeBase64(dynamic source) {
        if (source != null && source is String && source.isNotEmpty) {
          try {
            return base64Decode(source);
          } catch (e) {
            print('Error decoding base64 string: $e');
          }
        }
        return null;
      }

      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> barangMap = data[i];
      

        Uint8List? foto_barang = decodeBase64(barangMap['foto_barang']);
        Uint8List? foto_barang_depan = decodeBase64(barangMap['foto_barang_depan']);
        Uint8List? foto_barang_belakang = decodeBase64(barangMap['foto_barang_belakang']);
        Uint8List? foto_barang_kanan = decodeBase64(barangMap['foto_barang_kanan']);
        Uint8List? foto_barang_kiri = decodeBase64(barangMap['foto_barang_kiri']);

        Barang barang = Barang(
          id_barang: barangMap['id_barang'],
          nama_barang: barangMap['nama_barang'],
          kategori_barang: barangMap['kategori_barang'],
          kota: barangMap['kota'],
          provinsi: barangMap['provinsi'],
          harga_barang: barangMap['harga_barang'],
          deskripsi: barangMap['deskripsi'],
          kelipatan: barangMap['kelipatan'],
          tgl_publish: DateTime.parse(barangMap['tgl_publish']),
          tgl_expired: DateTime.parse(barangMap['tgl_expired']),
          foto_barang: foto_barang,
          foto_barang_depan: foto_barang_depan,
          foto_barang_belakang: foto_barang_belakang,
          foto_barang_kanan: foto_barang_kanan,
          foto_barang_kiri: foto_barang_kiri,
          status: barangMap['status'],
          nik: barangMap['nik']
        );
        setState(() {
          barangs.add(barang);
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

void _getOpenBarang() async {
    var response = await http.get(Uri.parse(Api.urlgetopenbarang));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];

      Uint8List? decodeBase64(dynamic source) {
        if (source != null && source is String && source.isNotEmpty) {
          try {
            return base64Decode(source);
          } catch (e) {
            print('Error decoding base64 string: $e');
          }
        }
        return null;
      }

      for (int i = 0; i < data.length; i++) {
        Map<String, dynamic> barangMap = data[i];
      

        Uint8List? foto_barang = decodeBase64(barangMap['foto_barang']);
        Uint8List? foto_barang_depan = decodeBase64(barangMap['foto_barang_depan']);
        Uint8List? foto_barang_belakang = decodeBase64(barangMap['foto_barang_belakang']);
        Uint8List? foto_barang_kanan = decodeBase64(barangMap['foto_barang_kanan']);
        Uint8List? foto_barang_kiri = decodeBase64(barangMap['foto_barang_kiri']);

        Barang barang = Barang(
          id_barang: barangMap['id_barang'],
          nama_barang: barangMap['nama_barang'],
          kategori_barang: barangMap['kategori_barang'],
          kota: barangMap['kota'],
          provinsi: barangMap['provinsi'],
          harga_barang: barangMap['harga_barang'],
          deskripsi: barangMap['deskripsi'],
          kelipatan: barangMap['kelipatan'],
          tgl_publish: DateTime.parse(barangMap['tgl_publish']),
          tgl_expired: DateTime.parse(barangMap['tgl_expired']),
          foto_barang: foto_barang,
          foto_barang_depan: foto_barang_depan,
          foto_barang_belakang: foto_barang_belakang,
          foto_barang_kanan: foto_barang_kanan,
          foto_barang_kiri: foto_barang_kiri,
          status: barangMap['status'],
          nik: barangMap['nik']
        );
        setState(() {
          barangs.add(barang);
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }


// void _cariBarang(String keyword) {
//   List<dynamic> filteredBarangs = [];

//   if (keyword.isEmpty) {
//     setState(() {
//       filteredBarangs.addAll(barangs);
//     });
//   } else {
//     barangs.forEach((barang) {
//       if (barang.nama.toLowerCase().contains(keyword.toLowerCase())) {
//         filteredBarangs.add(barang);
//       }
//     });
//   }

//   setState(() {
//     barangs = filteredBarangs;
//   });
// }
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