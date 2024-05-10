import 'dart:convert';
import 'dart:typed_data';

class Barang {
  final int id;
  final String nama;
  final String deskripsi;
  final int harga;
  final Uint8List? foto;

  Barang({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    this.foto,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      id: json['id'] as int,
      nama: json['nama'] as String,
      deskripsi: json['deskripsi'] as String,
      harga: json['harga'] as int,
      foto: json['foto'] != null ? base64Decode(json['foto'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'harga': harga,
      'foto': foto != null ? base64Encode(foto!) : null,
    };
  }
}
