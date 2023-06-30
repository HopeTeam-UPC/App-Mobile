class authModel{
  final String email;
  final String password;

  authModel({
    required this.email,
    required this.password
  });

  Map<String, dynamic> toJson() =>{
    'email': email,
    'password': password,
  };
}