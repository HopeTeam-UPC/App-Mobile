import 'package:flutter/material.dart';
import 'package:go2climb/services/hiredServiceApi.dart';

import '../models/agencyHiredService.dart';

class Clients extends StatefulWidget {
  const Clients({Key? key, required this.uId}) : super(key: key);
  final String uId;
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {

  List<agencyHiredService> services = [];

  @override
  void initState() {
    super.initState();
    getHiredServices();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mis Clientes"),
          backgroundColor: const Color(0xFF9CD4E7)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if(services.isEmpty)
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("No cuentas con clientes :(", style: TextStyle(fontWeight: FontWeight.bold),),
                  )
                ],
              ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: services.length,
                itemBuilder: (context, index){
                  final service = services[index];
                  return Card(
                    child: ListTile(
                      title: Text('${service.customer} ${service.lastName}'),
                      leading: Icon(Icons.circle_rounded,
                      color: service.status == 'active' ? Colors.lightGreenAccent : Colors.red),
                      trailing: Text('\$ ${service.price.toString()}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(service.serviceName),
                          Text(service.email),
                          Text(service.status),
                          Text(service.phone)
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
  
  Future<void>getHiredServices() async{
    var response = await hiredServiceApi.getAgencyHiredServices(widget.uId);
    setState(() {
      services = response;
    });
  }
}
