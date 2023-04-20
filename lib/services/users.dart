class users {
  final String username;
  final int mobile;
  final String email;
  final DateTime dob;

  users({
    required this.username,
    required this.mobile,
    required this.email,
    required this.dob
  });

  factory users.fromMap(Map<dynamic, dynamic> map) {
    return users(
      username: map['name'],
      mobile: map['age'],
      email: map['email'],
      dob: map['dob'],
    );
  }
}
