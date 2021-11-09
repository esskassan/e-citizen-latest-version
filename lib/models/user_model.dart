class Users {
  final int id;
  final String lastname;
  final String firstname;
  final String telephone;
  final String cardId;
  final String cardType;
  final String? email;
  final String? age;
  final String? profession;
  final String? photo;
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
