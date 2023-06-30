import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go2climb/screens/serviceDetails.dart';

import '../models/service.dart';
import '../services/agencyApi.dart';

class ofertas extends StatefulWidget {
  const ofertas({Key? key}) : super(key: key);

  @override
  State<ofertas> createState() => _ofertasState();
}

class _ofertasState extends State<ofertas> {
  List<Services> services = [];

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: services.length,
          itemBuilder: (context, index){
            final service = services[index];
            final name = service.name;
            final agencyName = service.agency.name;
            final price = service.price;
            final img = service.img_url;
            final rating = service.score.toDouble();
            final agencyRating = service.agency.score.toDouble();

            return InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detalle(serviceId: service.id),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(img,
                            height: 200,
                            width: 300)
                        //,
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,top: 10.0),
                      child: RatingBar.builder(
                        initialRating: rating,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemSize: 20.0,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 10.0),
                      child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 10.0),
                      child: Row(
                        children: [
                          Text('ofrecido por: $agencyName', textAlign: TextAlign.center,),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: RatingBar.builder(
                              initialRating: agencyRating,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              ignoreGestures: true,
                              itemSize: 15.0,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 10.0,bottom: 10),
                      child: Text('\$ $price.00', textAlign: TextAlign.center,),
                    )
                  ],
                ),
              ),
            );
          });
  }

  Future<void> fetchServices() async{
    final response = await AgencyApi.fetchServices();

    setState(() {
      services = response;
    });
  }
}
