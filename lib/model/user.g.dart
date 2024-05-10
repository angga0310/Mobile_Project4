// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String,
      nik: json['nik'] as String,
      email: json['email'] as String,
      alamat: json['alamat'] as String,
      nowa: json['no_wa'] as String,
      password: json['password'] as String? ?? '',
      level: (json['level'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nik': instance.nik,
      'email': instance.email,
      'alamat': instance.alamat,
      'no_wa': instance.nowa,
      'password': instance.password,
      'level': instance.level,
    };
