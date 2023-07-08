class ListDate {
  final int date_id;
  final String date_value;
  ListDate({
    required this.date_id,
    required this.date_value,
  });
  factory ListDate.fromJson(Map<String, dynamic> json) {
    return ListDate(
      date_id: json['date_id'],
      date_value: json['date_value'],
    );
  }
}
