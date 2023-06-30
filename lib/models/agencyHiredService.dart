class agencyHiredService{
  final String serviceName;
  final String customer;
  final String lastName;
  final String email;
  final int price;
  final String phone;
  final String status;

  agencyHiredService({
    required this.price,
    required this.email,
    required this.customer,
    required this.phone,
    required this.serviceName,
    required this.lastName,
    required this.status
  });

  factory agencyHiredService.fromJson(Map<String, dynamic> json){
    return agencyHiredService(
        price: json['service_id']['price'],
        email: json['customer_id']['email'],
        customer: json['customer_id']['name'],
        lastName: json['customer_id']['lastName'],
        phone: json['customer_id']['phoneNumber'],
        status: json['status'],
        serviceName: json['service_id']['name']);
    }

}