class tourist{
  final String name;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String img_url;

  tourist({
    required this.name,
    required this.lastName,
    required this.email,
    required this.img_url,
    required this.phoneNumber
});
  factory tourist.fromJson(Map<String, dynamic> json){
    return tourist(
        name: json['name'],
        lastName: json['lastName'],
        email: json['email'],
        img_url: json['img_url'],
        phoneNumber: json['phoneNumber']);
  }

}