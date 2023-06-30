class touristHiredService{
  final String service_id;
  final String serviceName;
  final int servicePrice;
  final String status;
  final String img_url;
  final String location;

  touristHiredService({
    required this.status,
    required this.serviceName,
    required this.service_id,
    required this.img_url,
    required this.servicePrice,
    required this.location
  });
  factory touristHiredService.fromJson(Map<String, dynamic> json){
    return touristHiredService(
        service_id: json['service_id']['_id'],
        serviceName: json['service_id']['name'],
        servicePrice: json['service_id']['price'],
        status: json['status'],
        img_url: json['service_id']['img_url'],
        location: json['service_id']['location']
    );
  }
}