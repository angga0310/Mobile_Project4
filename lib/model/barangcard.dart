import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:si_lelang/DetailBarangPage.dart';
import 'package:intl/intl.dart';
import 'package:si_lelang/model/barang.dart';

class BarangCard extends StatelessWidget {
  final Uint8List foto_barang;
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBarangPage(barang: barang),
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
                Positioned(
                  child: Container(
                    height: 157,
                    width: 192,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: Image.memory(
                        foto_barang,
                        height: 157,
                        width: 192,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                 if (barang.status == 'Open')
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      width: 36,
                      height: 18,
                      decoration: ShapeDecoration(
                        color: Color(0xFFFF782C),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
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
                    nama,
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
                    deskripsi.length > 50 ? '${deskripsi.substring(0, 50)}...' : deskripsi,
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
                    formatRupiah(harga_barang),
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

    String formatRupiah(int value) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(value);
  }
}