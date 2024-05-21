import 'dart:convert';
import 'dart:typed_data';

class Barang {
  final int id_barang;
  final String nama_barang;
  final String kategori_barang;
  final String kota;
  final String provinsi;
  final int harga_barang;
  final String deskripsi;
  final int kelipatan;
  final DateTime tgl_publish;
  final DateTime tgl_expired;
  final Uint8List? foto_barang;
  final Uint8List? foto_barang_depan;
  final Uint8List? foto_barang_belakang;
  final Uint8List? foto_barang_kanan;
  final Uint8List? foto_barang_kiri;
  final String status;
  final String nik;

  Barang({
    required this.id_barang,
    required this.nama_barang,
    required this.kategori_barang,
    required this.kota,
    required this.provinsi,
    required this.harga_barang,
    required this.deskripsi,
    required this.kelipatan,
    required this.tgl_publish,
    required this.tgl_expired,
    this.foto_barang,
    this.foto_barang_depan,
    this.foto_barang_belakang,
    this.foto_barang_kanan,
    this.foto_barang_kiri,
    required this.status,
    required this.nik,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      id_barang: json['id_barang'] as int,
      nama_barang: json['nama_barang'] as String,
      kategori_barang: json['kategori_barang'] as String,
      kota: json['kota'] as String,
      provinsi: json['provinsi'] as String,
      harga_barang: json['harga_barang'] as int,
      deskripsi: json['deskripsi'] as String,
      kelipatan: json['kelipatan'] as int,
      tgl_publish: DateTime.parse(json['tgl_publish'] as String),
      tgl_expired: DateTime.parse(json['tgl_expired'] as String),
      foto_barang: json['foto_barang'] != null ? base64Decode(json['foto_barang'] as String) : null,
      foto_barang_depan: json['foto_barang_depan'] != null ? base64Decode(json['foto_barang_depan'] as String) : null,
      foto_barang_belakang: json['foto_barang_belakang'] != null ? base64Decode(json['foto_barang_belakang'] as String) : null,
      foto_barang_kanan: json['foto_barang_kanan'] != null ? base64Decode(json['foto_barang_kanan'] as String) : null,
      foto_barang_kiri: json['foto_barang_kiri'] != null ? base64Decode(json['foto_barang_kiri'] as String) : null,
      status: json['status'] as String,
      nik: json['nik'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_barang': id_barang,
      'nama_barang': nama_barang,
      'kategori_barang' : kategori_barang,
      'kota' : kota,
      'provinsi' : provinsi,
      'harga_barang': harga_barang,
      'deskripsi': deskripsi,
      'kelipatan' : kelipatan,
      'tgl_publish' : tgl_publish.toIso8601String(),
      'tgl_expired' : tgl_expired.toIso8601String(),
      'foto_barang': foto_barang != null ? base64Encode(foto_barang!) : null,
      'foto_barang_depan': foto_barang_depan != null ? base64Encode(foto_barang_depan!) : null,
      'foto_barang_belakang': foto_barang_belakang != null ? base64Encode(foto_barang_belakang!) : null,
      'foto_barang_kanan': foto_barang_kanan != null ? base64Encode(foto_barang_kanan!) : null,
      'foto_barang_kiri': foto_barang_kiri != null ? base64Encode(foto_barang_kiri!) : null,
      'status' : status,
      'nik' : nik,
    };
  }
}