import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go2climb/models/activity.dart';
import 'package:go2climb/models/service.dart';
import 'package:go2climb/models/weather.dart';
import 'package:go2climb/screens/edit_service.dart';
import 'package:go2climb/screens/hire_service.dart';
import 'package:go2climb/services/activitiesApi.dart';
import 'package:go2climb/services/agencyApi.dart';
import 'package:go2climb/services/weather.dart';

class Detalle extends StatefulWidget {
  const Detalle({Key? key, required this.serviceId}) : super(key: key);
  final String serviceId;

  @override
  State<Detalle> createState() => _DetalleState();
}

class _DetalleState extends State<Detalle> {
  final storage = const FlutterSecureStorage();
  String uId = '';
  String usertype = '';
  List<Activity> activities = [];
  AgencyDetails agency = AgencyDetails(id: 'id', score: 0, name: 'name', email: 'email', description: 'description', location: 'location', phoneNumber: 'phoneNumber', img_url: 'https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image-300x225.png', type_user: 'type_user');
  late Services service = Services(id: 'id', name: 'name', price: 0, location: 'location', img_url: 'https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image-300x225.png', description: 'description', score: 0, agency: agency);
  String weather = '';
  double temp = 0;
  double tempmin = 0;
  double tempmax = 0;


  @override
  void initState() {
    super.initState();
    setParams();
    fetchActivities();
    fetchService();
    //fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF9CD4E7),
          title: Text(service.name)
      ),
      body: SingleChildScrollView(
        child: Column(
          children:<Widget> [
            if(usertype == 'agency' && service.agency.id == uId)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditService(aId: service.agency.id, sId: service.id)
                        )
                    );
                    },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9CD4E7),
                          foregroundColor: Colors.black,
                        fixedSize: Size(350, 15)
                      ),
                      child: const Text("Editar servicio")
                  )
                ],
              ),
            ),
            Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                      child: Image.network(service.img_url, height: 250, width: 350,),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(service.name, style:const TextStyle(fontWeight: FontWeight.bold) ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text("Lugar: ${service.location}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Ofrecido por: ${service.agency.name}"),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(service.description),
                        )
                      ],
                    )
                  ],
                ),
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: ListTile(
                title: Text('Clima: $weather'),
                subtitle: Column(
                  children: [
                    Text('Temp: $temp ºF'),
                    Text('Temp minima: $tempmin ºF'),
                    Text('Temp maxima: $tempmax ºF')
                  ],
                ),
                //weather.main?.temp,
              ),
            ),
            Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Las actividades que realizaras", style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    if (activities.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("No hay actividades disponibles"),
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: activities.length,
                        itemBuilder: (context, index){
                          final activity = activities[index];
                          return ListTile(
                            leading: const Icon(
                              Icons.circle_rounded,
                              color: Colors.lightBlueAccent,
                            ),
                            title: Text(activity.name),
                            subtitle: Text(activity.description),

                          );

                    }),
                  ],
                ),
            ),
            Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: const Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Es bueno saberlo", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("este servicio atiende a los visitantes de lunes a viernes"),
                    )
                  ],
                )
            ),
            if (usertype == 'customer')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('\$${service.price}', style: const TextStyle(fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9CD4E7),
                      foregroundColor: Colors.black
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HireService(sId: service, aId: service.agency.id)
                          )
                      );
                    },
                    child: const Text('Solicitar'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchActivities() async{
    final response = await activitiesApi.fetchActivitiesById(widget.serviceId);
    setState(() {
      activities = response;
    });

  }

  Future<void> fetchService() async{
    final response = await AgencyApi.fetchServicebyId(widget.serviceId);
    setState(() {
      service = response;
    });
    fetchWeather();
  }

  Future<void> fetchWeather() async{
    final response = await weatherApi.fetchbyId(service.location);
    setState(() {
      weather = response.weather[0].main;
      temp = response.main.temp;
      tempmin = response.main.tempMin;
      tempmax = response.main.tempMax;
    });
  }

  void setParams() async{


    var type = await storage.read(key: 'type');
    var id = await storage.read(key: 'id');

    setState(() {
      usertype = type!;
      uId = id!;
    });
  }

}

