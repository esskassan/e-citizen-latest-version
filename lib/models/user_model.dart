import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Users {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String lastname;
  @HiveField(2)
  final String firstname;
  @HiveField(3)
  final String telephone;
  @HiveField(4)
  final String cardId;
  @HiveField(5)
  final String cardType;
  @HiveField(6)
  final String? email;
  @HiveField(7)
  final String? age;
  @HiveField(8)
  final String? profession;
  @HiveField(9)
  final String? photo;
  @HiveField(10)
  final String token;

  Users({
    required this.id,
    required this.lastname,
    required this.firstname,
    required this.telephone,
    required this.cardId,
    required this.cardType,
    this.email,
    this.age,
    this.profession,
    this.photo,
    required this.token,
  });

  factory Users.fromJson(Map<String, dynamic> doc) {
    return Users(
      id: (int.tryParse(doc['id'])) ??
          1, //TODO: REMOVE THE PARSE ONCE RECEIVING REAL DATA
      lastname: doc['lastname'],
      firstname: doc['firstname'],
      telephone: doc['telephone'],
      cardId: doc['idNum'],
      cardType: doc['idType'],
      email: doc['email'],
      age: doc['date_naissance'],
      profession: doc['profession'],
      photo: doc['profile_photo_path'],
      token: doc['token'],
    );
  }

  factory Users.fromDB(Map<String, dynamic> doc) {
    return Users(
      id: doc['id'],
      lastname: doc['lastname'],
      firstname: doc['firstname'],
      telephone: doc['telephone'],
      cardId: doc['idNum'],
      cardType: doc['idType'],
      email: doc['email'],
      age: doc['date_naissance'],
      profession: doc['profession'],
      photo: doc['profile_photo_path'],
      token: doc['token'],
    );
  }

  toMap() {
    return {
      'id': id,
      'lastname': lastname,
      'firstname': firstname,
      'telephone': telephone,
      'idNum': cardId,
      'idType': cardType,
      'email': email ?? "",
      'date_naissance': age ?? "",
      'profession': profession ?? "",
      'profile_photo_path': photo ?? "",
      'token': token
    };
  }
}
