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
    String foto; 
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

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
