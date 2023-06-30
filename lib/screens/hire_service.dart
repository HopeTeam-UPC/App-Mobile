import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go2climb/models/hiredService.dart';
import 'package:go2climb/models/service.dart';
import 'package:go2climb/services/hiredServiceApi.dart';

class HireService extends StatefulWidget {
  const HireService({Key? key, required this.sId, required this.aId}) : super(key: key);
  final Services sId;
  final String aId;

  @override
  _HireServiceState createState() => _HireServiceState();

}

class _HireServiceState extends State<HireService> {
  final storage = FlutterSecureStorage();

  String status = 'active';
  late String service_id;
  late String customer_id;
  late String agency_id;

  @override
  void initState() {
    super.initState();
    setIds();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9CD4E7),
        title: const Text('Pagar servicio'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget> [
            Card(
              child: Column(
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Detalles de pago", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(widget.sId.img_url),
                    ),
                    title: Text(
                      widget.sId.name
                    ),
                    subtitle: Text(
                      widget.sId.location
                    ),
                    trailing: Text(
                      "\$${widget.sId.price.toString()}"
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Nombres",
                          labelText: "Nombres",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Numero de Tarjeta",
                          labelText: "Numero de Tarjeta",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                          )
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget> [
                SizedBox(
                  width: 145,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "CCV",
                      labelText: "CCV",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                      )
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: 145,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "MM/YYYY",
                          labelText: "Vencimiento",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))
                          )
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9CD4E7),
                      foregroundColor: Colors.black
                  ),
                  onPressed: (){
                  payment();
                }, child: const Text('Pagar'),

                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showMessage(int status){
    if (status == 200){
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Exito'),
          content: const Text('Se registro la compra de forma exitosa'),
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

  setIds() async{
    var id = await storage.read(key: 'id');
    setState(() {
      service_id = widget.sId.id;
      agency_id = widget.aId;
      customer_id = id!;
    });
  }

  Future<void>payment() async{
    hiredService service = hiredService(status: status, service_id: service_id, customer_id: customer_id, agency_id: agency_id);
    var json = jsonEncode(service.toJson());
    int code = await hiredServiceApi.postHiredService(json);

    showMessage(code);

  }
}
