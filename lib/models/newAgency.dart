class newAgency{
  final String name;
  final String email;
  final String password;
  final String description;
  final String location;
  final String ruc;
  final String phoneNumber;
  final String img_url;
  final String type_user;
  newAgency({
    required this.type_user,
    required this.img_url,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.name,
    required this.location,
    required this.description,
    required this.ruc
  });

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'password': password,
        'img_url': img_url,
        'email': email,
        'phoneNumber': phoneNumber,
        'type_user': type_user,
        'ruc': ruc,
        'description': description,
        'location': location,

      };

}