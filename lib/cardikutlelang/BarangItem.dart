import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:si_lelang/model/barang.dart';

class BarangItemWidget extends StatelessWidget {
  final Barang barang;
  final double tawaran;

  BarangItemWidget({required this.barang, required this.tawaran});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Adjust as needed
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            barang.nama_barang,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          Text(
            'Tawaran: \$${tawaran.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
          Text(
            'Expired: ${DateFormat.yMMMd().format(barang.tgl_expired)}',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

