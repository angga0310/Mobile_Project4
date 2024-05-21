import 'package:flutter/material.dart';
import 'package:si_lelang/cardikutlelang/BarangItem.dart';
import 'package:si_lelang/model/barang.dart';

class BarangItemCard extends StatelessWidget {
  final List<Barang> barangs;
  final List<double> tawarans;

  BarangItemCard({required this.barangs, required this.tawarans});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 390,
        height: 90,
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: barangs.length,
          itemBuilder: (context, index) {
            return BarangItemWidget(barang: barangs[index], tawaran: tawarans[index]);
          },
        ),
      ),
    );
  }
}