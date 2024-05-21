import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:si_lelang/database/api.dart';

class BottomSheetBid {
  final BuildContext context;
  final String judul;
  final int harga_barang;
  final int kelipatan;
  final String nik;
  final int id_barang;

  BottomSheetBid({
    required this.context,
    required this.judul,
    required this.harga_barang,
    required this.kelipatan,
    required this.nik,
    required this.id_barang,
  });

  Future<String?> show() async {
    Completer<String?> completer = Completer<String?>();
    final TextEditingController bidController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  judul,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Harga Barang: $harga_barang',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Kelipatan Penawaran: $kelipatan',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: bidController,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Tawaran Anda',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [ThousandsFormatter()],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    String bidValue = bidController.text.replaceAll(',', '');
                    await bidBarang(bidValue);
                    completer.complete(bidValue);
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text('Ajukan Tawaran'),
                  ),
                ),
                SizedBox(height: 12)
              ],
            ),
          ),
        );
      },
    );
    return completer.future;
  }

  Future<void> bidBarang(String hargaBid) async {
    try {
      var response = await http.post(
        Uri.parse(Api.urlbid),
        body: jsonEncode({
          'harga_bid': hargaBid,
          'id_barang': id_barang.toString(),
          'nik': nik,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Bid berhasil');
        print(jsonDecode(response.body)['data']);

      } else {
        print('Bid gagal');
        print(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}

// ThousandsFormatter untuk memformat angka ribuan pada TextField
class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else {
      final regEx = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      String newText = newValue.text.replaceAll(',', '');
      newText = newText.replaceAllMapped(
          regEx, (Match match) => '${match.group(1)},');
      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }
}
