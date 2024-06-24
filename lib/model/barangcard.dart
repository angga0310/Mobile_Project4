import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:si_lelang/DetailBarangPage.dart';
import 'package:intl/intl.dart';
import 'package:si_lelang/database/api.dart';
import 'package:si_lelang/model/barang.dart';
import 'package:http/http.dart' as http;

class BarangCard extends StatefulWidget {
  final String foto_barang;
  final String nama;
  final String deskripsi;
  final int harga_barang;
  final Barang barang;

  const BarangCard({
    Key? key,
    required this.foto_barang,
    required this.nama,
    required this.deskripsi,
    required this.harga_barang,
    required this.barang,
  }) : super(key: key);

  @override
  State<BarangCard> createState() => _BarangCardState(barang: barang);
}

class _BarangCardState extends State<BarangCard> {
  Barang barang;
  _BarangCardState({required this.barang});
  String imageData = '';

  @override
  void initState() {
    super.initState();
    getFotoBarang();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBarangPage(barang: widget.barang),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 157,
                  width: 192,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: imageData != ''
                        ? Image.memory(
                            base64Decode(imageData),
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Color(0xFF35755D),
                              ),
                            ),
                          ),
                  ),
                ),
                if (widget.barang.status.toLowerCase() == 'open')
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      width: 36,
                      height: 18,
                      decoration: ShapeDecoration(
                        color: Color(0xFFFF782C),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9)),
                      ),
                      child: Center(
                        child: Text(
                          'Live',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nama,
                    style: const TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.deskripsi.length > 50
                        ? '${widget.deskripsi.substring(0, 50)}...'
                        : widget.deskripsi,
                    style: const TextStyle(
                      color: Color(0xFF606060),
                      fontSize: 10,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatRupiah(widget.harga_barang),
                    style: const TextStyle(
                      color: Color(0xFF20AD2E),
                      fontSize: 14,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getFotoBarang() async {
    try {
      final response = await http.get(Uri.parse(
          '${Api.urlfoto}?image_path=${barang.foto_barang}'));
      // final response = await http.get(Uri.parse('${Api.urlImage}/${event.uploadPamflet}?w=30&h=40'));
      if (response.statusCode == 200) {
        String data = json.decode(response.body)['base64Image'];
        if (!mounted) return;
        setState(() {
          imageData = data.replaceAll(RegExp(r'\s'), '');
        });
      } else {}
    } catch (e) {}
  }

  String formatRupiah(int value) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(value);
  }
}
