class Speciality {
  final int specialty_id;
  final String name;
  final String description;
  final String price;

  Speciality({
    required this.specialty_id,
    required this.name,
    required this.description,
    required this.price,
  });
  factory Speciality.fromJson(Map<String, dynamic> json) {
    return Speciality(
      specialty_id: json['specialty_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
    );
  }
}
