import 'package:flutter/material.dart';
import 'package:si_lelang/model/barang.dart';

class DetailBarangPage extends StatefulWidget {
  final Barang barang;

  const DetailBarangPage({Key? key, required this.barang}) : super(key: key);

  @override
  State<DetailBarangPage> createState() => _DetailBarangPageState();
}

class _DetailBarangPageState extends State<DetailBarangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.barang.nama),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 332,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(widget.barang.foto!),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Deskripsi:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.barang.deskripsi,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  'Harga: Rp ${widget.barang.harga}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Tambahkan logika untuk mengikuti lelang atau menawar barang
              // Misalnya, tampilkan dialog atau lakukan aksi tertentu
            },
            child: const Text('Ikuti Lelang / Tawar Barang'),
          ),
        ],
      ),
    );
  }
}
