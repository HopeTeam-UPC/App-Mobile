class newCustomer{
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String img_url;
  final String type_user;
  newCustomer({
    required this.name,
    required this.lastName,
    required this.password,
    required this.email,
    required this.phoneNumber,
    required this.img_url,
    required this.type_user


});
  Map<String, dynamic> toJson() =>
      {
        //'_id': id,
        'name': name,
        'lastName': lastName,
        'password': password,
        'img_url': img_url,
        'email': email,
        'phoneNumber': phoneNumber,
        'type_user': type_user

      };
}