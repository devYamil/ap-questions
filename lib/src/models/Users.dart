class Users {
  final int id;
  final String name;
  final String email;
  final String image;
  Users({
    this.id,
    this.name,
    this.email,
    this.image,
  });

  factory Users.formJson(Map<String, dynamic> json) {
    return new Users(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
    );
  }
}
