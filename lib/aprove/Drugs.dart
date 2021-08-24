class Drugs {
  // ignore: non_constant_identifier_names
  Drugs({this.id, this.firstName, this.lastName, this.Check});

  factory Drugs.fromJson(Map<String, dynamic> json) {
    return Drugs(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      Check: json['check1'] as String,
    );
  }

  String firstName;
  String id;
  String lastName;
  // ignore: non_constant_identifier_names
  String Check;


}