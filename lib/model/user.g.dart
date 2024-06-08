// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      nik: json['nik'].toString(),
      nama: json['nama'] as String,
      jenis_kelamin: json['jenis_kelamin'] as String,
      tempat_lahir: json['tempat_lahir'] as String,
      tanggal_lahir: DateTime.parse(json['tanggal_lahir'] as String),
      alamat: json['alamat'] as String,
      nohp: json['nohp'] as String,
      foto: json['foto'] as String,
      email: json['email'] as String,
      password: json['password'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'nik': instance.nik,
      'nama': instance.nama,
      'jenis_kelamin': instance.jenis_kelamin,
      'tempat_lahir': instance.tempat_lahir,
      'tanggal_lahir': instance.tanggal_lahir.toIso8601String(),
      'alamat': instance.alamat,
      'nohp': instance.nohp,
      'foto': instance.foto,
      'email': instance.email,
      'password': instance.password,
    };
