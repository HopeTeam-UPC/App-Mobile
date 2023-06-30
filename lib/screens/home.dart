import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go2climb/models/newService.dart';
import 'package:go2climb/models/service.dart';
import 'package:go2climb/screens/create_service.dart';
import 'package:go2climb/screens/search.dart';
import 'package:go2climb/services/agencyApi.dart' ;
import 'package:go2climb/widgets/myDrawer.dart';
import 'package:go2climb/widgets/offers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Services> services = [];
  final storage = FlutterSecureStorage();
  String userType = '';

  @override
  void initState() {
    super.initState();
    setParams();
    fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFF9CD4E7),
            title: const Text("Home"),

          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Search())
                );
              },
            )
          ],
          bottom: const TabBar(
            tabs:<Widget> [
              Tab(
                  icon: Icon(Icons.monetization_on),
                  text: 'Ofertas'
              ),
              Tab(
                  icon: Icon(Icons.star),
                  text: 'Populares'
              ),
              Tab(
                  icon: Icon(Icons.radar),
                text: 'Para ti',
              )
            ],
          ),

        ),
        drawer: const myDrawer(),
        body: const TabBarView(
          children:<Widget>
          [ofertas(),
            ofertas(),
            ofertas()
          ],

        ) ,

        floatingActionButton: userType.contains('agency') ? FloatingActionButton(
          backgroundColor: const Color(0xFF9CD4E7),
          child: const Icon(Icons.add),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => CreateService())
                );
            },
        ) : Container(),
      ),
    );
  }

  Future<void> fetchServices() async{
    final response = await AgencyApi.fetchServices();

    setState(() {
      services = response;
    });
  }

  void setParams() async{


    var type = await storage.read(key: 'type');
    setState(() {
      userType = type!;
    });
  }
}
