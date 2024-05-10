import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    int id;
    String name;
    String nik;
    String email;
    String alamat;
    @JsonKey(name: 'no_wa')
    String nowa;
    String password;
    int level;

    User({
        this.id = 0,
        required this.name,
        required this.nik,
        required this.email,
        required this.alamat,
        required this.nowa,
        this.password = '',
        this.level = 1,
    });
    
    factory User.fromMap(Map<String, dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toMap() => _$UserToJson(this);
}
