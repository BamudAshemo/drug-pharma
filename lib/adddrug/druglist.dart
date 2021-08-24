class Drug {
  // ignore: non_constant_identifier_names
  Drug({this.id, this.drugName, this.drugFamily, this.description});

  factory Drug.fromJson(Map<String, dynamic> json) {
    return Drug(
      id: json['id'] as String,
      drugName: json['drugname'] as String,
      drugFamily: json['drugfamily'] as String,
      description: json['description'] as String,
    );
  }

  String drugName;
  String id;
  String drugFamily;
  // ignore: non_constant_identifier_names
  String description;


}