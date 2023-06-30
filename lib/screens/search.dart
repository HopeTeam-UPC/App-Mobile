import 'package:flutter/material.dart';
import 'package:go2climb/screens/serviceDetails.dart';
import 'package:go2climb/services/agencyApi.dart';

import '../models/newService.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  String word = '';
  List<newService> services = [];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Busqueda", style: TextStyle(color: Colors.black),),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white70,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: const InputDecoration(
                    hintText: "Inserte su busqueda",
                    labelText: "Inserte su busqueda",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                    )
                )
                ,
                onChanged: (value){

                    word = value;
                  }

              ),
            ),
            ListView.builder(
              itemCount: services.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final service = services[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(service.img_url),
                  ),
                  title: Text(service.name),
                  subtitle: Text(service.location),
                  trailing: Text('\$${service.price}'),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detalle(serviceId: service.id),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF9CD4E7),
        child: const Icon(Icons.search),
        onPressed: (){
          print("searching: $word ");
          search();
        },
      ),
    );
  }

  Future<void> search() async{
    var response = await AgencyApi.searchService(word);
    setState(() {
      services = response;
    });

  }
}
