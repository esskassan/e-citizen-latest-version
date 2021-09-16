class User {
  final int id;
  final String lastName;
  final String firstName;
  final String phoneNumber;
  User({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.phoneNumber,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'last_name': lastName,
      'first_name': firstName,
      'phone_number': phoneNumber,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'User{id: $id, last_name: $lastName, first_name: $firstName, phone_number: $phoneNumber}';
  }
}
