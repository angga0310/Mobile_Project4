// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barang.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Barang _$BarangFromJson(Map<String, dynamic> json) => Barang(
      id_barang: json['id_barang'] as int,
      nama_barang: json['nama_barang'] as String,
      kategori_barang: json['kategori_barang'] as String,
      kota: json['kota'] as String,
      provinsi: json['provinsi'] as String,
      harga_barang:  json['harga_barang'] as int,
      deskripsi: json['deskripsi'] as String,
      kelipatan: (json['kelipatan'] as num).toInt(),
      tgl_publish: DateTime.parse(json['tgl_publish'] as String),
      tgl_expired: DateTime.parse(json['tgl_expired'] as String),
      foto_barang: json['foto_barang'] as String,
      foto_barang_depan: json['foto_barang_depan'] as String,
      foto_barang_belakang: json['foto_barang_belakang'] as String,
      foto_barang_kanan: json['foto_barang_kanan'] as String,
      foto_barang_kiri: json['foto_barang_kiri'] as String,
      status: json['status'] as String,
      nik: json['nik'] as String,
    );

Map<String, dynamic> _$BarangToJson(Barang instance) => <String, dynamic>{
      'id_barang': instance.id_barang,
      'nama_barang': instance.nama_barang,
      'kategori_barang': instance.kategori_barang,
      'kota': instance.kota,
      'provinsi': instance.provinsi,
      'harga_barang': instance.harga_barang,
      'deskripsi': instance.deskripsi,
      'kelipatan': instance.kelipatan,
      'tgl_publish': instance.tgl_publish.toIso8601String(),
      'tgl_expired': instance.tgl_expired.toIso8601String(),
      'foto_barang': instance.foto_barang,
      'foto_barang_depan': instance.foto_barang_depan,
      'foto_barang_belakang': instance.foto_barang_belakang,
      'foto_barang_kanan': instance.foto_barang_kanan,
      'foto_barang_kiri': instance.foto_barang_kiri,
      'status': instance.status,
      'nik': instance.nik,
    };
