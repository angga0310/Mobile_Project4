import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuctionCard extends StatelessWidget {
  final String nama_barang;
  final String harga_bid;
  final String tgl_expired;

  AuctionCard({
    required this.nama_barang,
    required this.harga_bid,
    required this.tgl_expired,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: 91,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Lelang Berlangsung',
                  style: TextStyle(
                      fontFamily: 'Lexend', fontSize: 10, color: Color(0xFF606060)),
                ),
                SizedBox(width: 180,),
                Text(
                  'Lihat semua',
                  style: TextStyle(
                      fontFamily: 'Lexend', fontSize: 10, color: Color(0xFF606060)),
                ),
                Icon(Icons.arrow_forward,
                  size: 18,
                )
              ],
            ),
            Text(
              nama_barang,
              style: const TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 16,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Text(
                  'Tawaran Anda: $harga_bid',
                  style: const TextStyle(
                    color: Color(0xFF20AD2E),
                    fontSize: 10,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
                SizedBox(
                  width: 120,
                ),
                Text(
                  'Berakhir pada: $tgl_expired',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 228, 21, 21),
                    fontSize: 10,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        ]
      ),
    );
  }
}
