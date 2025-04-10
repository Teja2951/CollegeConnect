class StudentBody {
  final String id;
  final String name;    
  final String? description;
  final List? admins;

  StudentBody({
    required this.id,
    required this.name,
    this.description,
    this.admins,
  });

  factory StudentBody.fromMap(Map<String, dynamic> data, String id) {
    return StudentBody(
      id: id,
      name: data['name'],
      description: data['description'],
      admins: data['admins'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'admins':admins,
    };
  }
}
