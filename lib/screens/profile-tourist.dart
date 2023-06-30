import 'package:flutter/material.dart';
import 'package:go2climb/models/tourist.dart';
import 'package:go2climb/models/touristHiredService.dart';
import 'package:go2climb/services/hiredServiceApi.dart';
import 'package:go2climb/widgets/myDrawer.dart';

import '../services/touristApi.dart';

class ProfileTourist extends StatefulWidget {
  const ProfileTourist({Key? key, required this.uId}) : super(key: key);
  final String uId;


  @override
  _ProfileTouristState createState() => _ProfileTouristState();
}

class _ProfileTouristState extends State<ProfileTourist> {
  tourist turista = tourist(name: '', lastName: 'lastName', email: 'email', img_url: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', phoneNumber: 'phoneNumber');
  List<touristHiredService> services = [];

  @override
  void initState() {
    super.initState();
    fetchTourist();
    fetchServices();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9CD4E7),
        title: Text("Perfil Turista"),
      ),
      drawer: myDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(turista.img_url),

                        ),
                      ],
                    ),
                    Text('${turista.name} ${turista.lastName}', style: const TextStyle(fontSize: 20.0),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Email: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(turista.email),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Telefono: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(turista.phoneNumber),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            Card(
              child: Column(
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Servicios contratados", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      )
                    ],
                  ),
                  if (services.isEmpty)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Aun no has contratado ningun servicio")],
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: services.length,
                      itemBuilder: (context, index){
                        final service = services[index];
                        return ListTile(
                          title: Text('${service.serviceName}'),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(service.img_url),
                          ),
                          trailing: Text('\$ ${service.servicePrice.toString()}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(service.location),
                              Text(service.status)
                            ],
                          ),
                        );
                      }),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
  Future<void> fetchTourist() async{
    var response = await touristApi.fetchbyId(widget.uId);

    setState(() {
      turista = response;

    });
  }

  Future<void> fetchServices() async{
    var response = await hiredServiceApi.getTouristHiredServices(widget.uId);
    setState(() {
      services = response;
    });
}
}
