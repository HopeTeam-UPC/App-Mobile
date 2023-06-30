import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go2climb/models/newService.dart';
import 'package:go2climb/services/agencyApi.dart';

class CreateService extends StatefulWidget {
  const CreateService({Key? key}) : super(key: key);

  @override
  _CreateServiceState createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
  final storage = FlutterSecureStorage();
  int price = 0;
  String name = "";
  String location = "";
  String img_url = "";
  String description = "";
  bool isOffer = false;
  int priceOffer = 0;
  late String agencyId;
  int score = 0;

  @override
  void initState() {
    super.initState();
    setAgencyId();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white70,
          title: const Text("Nuevo Servicio", style: TextStyle(color: Colors.black),)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                  hintText: "Nombre del Servicio",
                  labelText: "Nombre del Servicio",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  )
              )
              ,
              onChanged: (value){
                setState(() {
                  name = value;
                });
              },
            ),
            const Divider(
              height: 18.0,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: "Lugar",
                  labelText: "Lugar",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  )
              )
              ,
              onChanged: (value){
                setState(() {
                  location = value;
                });
              },
            ),
            const Divider(
              height: 18.0,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: "Precio",
                  labelText: "Precio",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                      )
                  ),
                keyboardType: TextInputType.number
              ,
              onChanged: (value){
                setState(() {
                  price = int.parse(value);
                });
              },
            ),
            const Divider(
              height: 18.0,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: "Foto",
                  labelText: "Foto",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  )
              )
              ,
              onChanged: (value){
                setState(() {
                  img_url = value;
                });
              },
            ),
            const Divider(
              height: 18.0,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: "Descripcion",
                  labelText: "Descripcion",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  )
              )
              ,
              onChanged: (value){
                setState(() {
                  description = value;
                });
              },
            ),
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  value: isOffer,
                  onChanged: (bool? value) {
                    setState(() {
                      isOffer = value!;
                    });
                  },
                ),
                const Text("Marcar como oferta")
              ],
            ),
            if(isOffer == true)
            TextField(
              decoration: const InputDecoration(
                  hintText: "Precio de Oferta",
                  labelText: "Precio de Oferta",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  )
              ),
                keyboardType: TextInputType.number,
              onChanged: (value){
                setState(() {
                  priceOffer = int.parse(value);
                });
              },
            ),
            ElevatedButton(onPressed: (){
              createService();
            }, child: const Text("Crear"))
          ],
        ),
      ),
    );
  }

  Future<void> createService() async{
    newService service = newService(id:'' ,name: name, price: price, location: location, img_url: img_url, description: description, score: score, agencyId: agencyId, priceOffer: priceOffer, isOffer: isOffer);
    var json = jsonEncode(service.toJson());
    int status = await AgencyApi.postService(json);
    showMessage(status);

  }

  void showMessage(int status){
    if (status == 200){
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Exito'),
          content: const Text('Servicio creado de forma exitosa'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    else{
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Ups'),
          content: const Text('Ocurrio un error al procesar la solicitud'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void setAgencyId() async{
    var id = await storage.read(key: 'id');
    setState(() {
      agencyId = id!;
    });
  }
}
