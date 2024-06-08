import 'package:json_annotation/json_annotation.dart';

part 'barang.g.dart';
@JsonSerializable()
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
  final String foto_barang;
  final String foto_barang_depan;
  final String foto_barang_belakang;
  final String foto_barang_kanan;
  final String foto_barang_kiri;
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
    required this.foto_barang,
    required this.foto_barang_depan,
    required this.foto_barang_belakang,
    required this.foto_barang_kanan,
    required this.foto_barang_kiri,
    required this.status,
    required this.nik,
  });

  factory Barang.fromJson(Map<String, dynamic> json) => _$BarangFromJson(json);
  Map<String, dynamic> toJson() => _$BarangToJson(this);
}
