class user_data {
  String? complainant_name;
  String? category;

  user_data({
    required this.complainant_name,
    required this.category,
  });

  user_data.fromJson(Map<String, dynamic> json) {
    complainant_name:
    json['ComplainantName'];
    category:
    json['ComplaintCategory'];
  }
}
