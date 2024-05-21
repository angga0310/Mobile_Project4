import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    String nik;
    String nama;
    String jenis_kelamin;
    String tempat_lahir;
    DateTime tanggal_lahir;
    String alamat;
    String nohp;
    @JsonKey(fromJson: _uint8ListFromBase64, toJson: _uint8ListToBase64)
    Uint8List foto;
    String email;
    String password;

    User({
        required this.nik,
        required this.nama,
        required this.jenis_kelamin,
        required this.tempat_lahir,
        required this.tanggal_lahir,
        required this.alamat,
        required this.nohp,
        required this.foto,
        required this.email,
        this.password = '',
    });
    

    static Uint8List _uint8ListFromBase64(String base64String) => base64Decode(base64String);
    static String _uint8ListToBase64(Uint8List uint8List) => base64Encode(uint8List);

    factory User.fromMap(Map<String, dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toMap() => _$UserToJson(this);
}
