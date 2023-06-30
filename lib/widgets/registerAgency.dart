
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go2climb/models/newAgency.dart';
import 'package:go2climb/services/auth.dart';
import 'package:go2climb/widgets/login.dart';
import 'package:go2climb/widgets/registerTourist.dart';

import '../screens/home.dart';
class RegisterAgency extends StatefulWidget{
  @override
  _RegisterAgencyFormState createState() => _RegisterAgencyFormState();
}

class _RegisterAgencyFormState extends State<RegisterAgency>{
  bool _obscureText = true;
  late String _name;
  late String _country;
  late String _phone;
  late String _email;
  late String _ruc;
  late String _ubicacion;
  late String description;
  late  String _password;
  bool isChecked = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Register",
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children:<Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Te damos la bienvenida a Go2Climb",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.left,
              ),
              const Divider(
                height: 18.0,
              ),
              TextField(
                enableInteractiveSelection: false,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                    hintText: "Correo electronico",
                    labelText: "Correo electronico",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)
                        )
                    )
                ),
                onChanged: (valor){
                  _email = valor;
                },
              ),
              TextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                    hintText: "Contraseña",
                    labelText: "Contraseña",
                    suffixIcon: IconButton(
                      icon:Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: (){
                        setState(() {
                          _obscureText=!_obscureText;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)
                        )
                    )
                ),
                onChanged: (valor){
                  _password = valor;
                },
              ),


              const Text(
                "Informacion de la Agencia",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.left,
              ),
              const Divider(
                  height: 20.0
              ),
              TextField(
                enableInteractiveSelection: false,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                    hintText: "nombre de la agencia",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)
                        )
                    )
                ),
                onChanged: (valor){
                  _name = valor;
                },

              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      enableInteractiveSelection: false,
                      autofocus: true,
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                          hintText: "numero de contacto",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0)
                              )
                          )
                      ),
                      onChanged: (valor){
                        _phone = valor;
                      },
                    ),

                  ),
                  Expanded(
                    child: TextField(
                      enableInteractiveSelection: false,
                      autofocus: true,
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                          hintText: "ruc",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.0)
                              )
                          )
                      ),
                      onChanged: (valor){
                        _ruc = valor;
                      },
                    ),

                  )
                ],
              ),
              TextField(
                enableInteractiveSelection: false,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                    hintText: "Ubicacion fisica de la agencia",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)
                        )
                    )
                ),

                onChanged: (valor){
                  _ubicacion = valor;
                },
              ),
              TextField(
                enableInteractiveSelection: false,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                    hintText: "Descripcion de la agencia",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)
                        )
                    )
                ),
                onChanged: (valor){
                  description = valor;
                },

              ),
              const Divider(
                height: 20.0,
              ),


              Row(
                children: [
                  Expanded(
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: const Text(
                        "Acepto los terminos y condiciones de Go2Climb",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: () {
                        termsAndConditions();
                      },
                    ),
                  ),
                ],
              ),


              Row(
                children: [
                  Expanded(
                    child:  ElevatedButton(
                      child: const Text("Continuar"),
                      onPressed: (){
                        register();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF9CD4E7)
                      ),
                    ),

                  )

                ],
              ),

            ],


          )

        ],
      ),
    );
  }
  void showMessage(){
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Ocurrio un error al realizar el registro'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
  }
  Future<void> register() async{

    newAgency agency = newAgency(type_user: 'agency', img_url: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        phoneNumber: _phone, email: _email, password: _password, name: _name, location: _ubicacion, description: description, ruc: _ruc);
    var json = jsonEncode(agency.toJson());
    var response = await authService.postAgency(json);
    if(response == 200){
      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPlan()));
    }
    else {
      showMessage();
    }
  }

  void termsAndConditions(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Terminos y condiciones'),
        content: const Text('Aceptación de los términos: Al acceder o utilizar nuestros servicios, el usuario acepta y se compromete a cumplir con los términos y condiciones establecidos en este documento.'),
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


class RegisterPlan extends StatefulWidget{
  @override
  _RegisterPlanFormState createState() => _RegisterPlanFormState();
}

class _RegisterPlanFormState extends State<RegisterPlan>{
  bool _obscureText = true;
  late String _numeroTarjeta;
  late String _nombreTarjeta;
  late String _cvc;
  late String _mmAA;
  late String _ruc;
  late String _ubicacion;
  late String description;
  late  String _password;
  bool isChecked = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text("Register",
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children:<Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Selecciona un plan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.left,
              ),
              Divider(
                height: 18.0,
              ),
              SizedBox(
                height: 230,
                child: Row(
                  children: [
                    Container(
                      width: 110,
                      child: ElevatedButton(

                          child: const Column(
                           children:<Widget> [

                             Padding(
                               padding: EdgeInsets.only(
                                   top: 8.0,
                                   bottom: 8.0
                               ),
                               child:  Text("Plan basico",
                               style: TextStyle(
                                 color: Colors.black,
                               ),
                               ),

                             ),
                             Padding(
                               padding: EdgeInsets.all(8.0),
                               child:  Icon(
                                 Icons.key,
                                 color: Colors.orange,
                                 size: 30.0,
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.all(8.0),
                               child:
                               Text(
                                   "publicar 3 servicios",
                                 style: TextStyle(
                                   color: Colors.black,
                                 ),
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.only(
                                   top: 8.0,
                                   bottom: 8.0),
                               child:  Text(
                                 "20.00USD",
                                 style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize:20.0,
                                   color: Colors.black
                                 ),
                               )
                             ),


                           ],

                          ),
                        onPressed: (){
                      },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                side: BorderSide(color: Colors.lightBlueAccent),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                ),
                              ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      child: ElevatedButton(

                          child: Column(
                            children:<Widget> [

                              Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0
                                ),
                                child:  Text("Plan Estandar",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child:  Icon(
                                  Icons.key,
                                  color: Colors.grey,
                                  size: 30.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                Text(
                                    "publicar 10 servicios",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8.0),
                                  child:  Text(
                                    "35.00USD",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:20.0,
                                      color: Colors.black
                                    ),
                                  )
                              ),


                            ],

                          ),
                          onPressed: (){
                          }, style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                      side: BorderSide(color: Colors.lightBlueAccent),

                    ),
              ),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
                      ),
                    ),
                    Container(
                      width: 110,
                      child: ElevatedButton(

                          child: Column(
                            children:<Widget> [

                              Padding(
                                padding: EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0
                                ),
                                child:  Text("Plan Premium",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child:  Icon(
                                  Icons.key,
                                  color: Colors.yellowAccent,
                                  size: 30.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                Text(
                                    "publicar 50 servicios",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8.0),
                                  child:  Text(
                                    "45.00USD",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:20.0,
                                      color: Colors.black
                                    ),
                                  )
                              ),


                            ],

                          ),
                          onPressed: (){
                          }, style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            side: BorderSide(color: Colors.lightBlueAccent),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      ),
                    ),



                  ],
                ),
              ),
              Divider(
                height: 10.0,
              ),

              Text(
                "* El pago se realizara cada mes de forma automatica, puede cancelar en cualquier momento",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              Divider(
                height: 10.0,
              ),
              Text(
                "Metodo de pago",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),



              Divider(
                  height: 10.0
              ),
              TextField(
                enableInteractiveSelection: false,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                    hintText: "Numero de tarjeta debito/credito",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)
                        )
                    )
                ),
                onSubmitted: (valor){
                  _numeroTarjeta = valor;
                },

              ),
              TextField(
                enableInteractiveSelection: false,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                    hintText: "Nombre del titular de la cuenta",
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0)
                )
                ),
                onSubmitted: (valor){
                  _nombreTarjeta = valor;
                },

              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      enableInteractiveSelection: false,
                      autofocus: true,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                          hintText: "MM/AA",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0)
                              )
                          )
                      ),
                      onSubmitted: (valor){
                        _mmAA = valor;
                      },
                    ),

                  ),
                  Expanded(
                    child: TextField(
                      enableInteractiveSelection: false,
                      autofocus: true,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                          hintText: "CVC/CVV",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.0)
                              )
                          )
                      ),
                      onSubmitted: (valor){
                        _cvc = valor;
                      },
                    ),

                  )
                ],
              ),

              Divider(
                height: 20.0,
              ),


              Row(
                children: [
                  Expanded(
                    child:  ElevatedButton(
                      child: Text("Registrarse"),
                      onPressed: (){
                        showMessage();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF9CD4E7)
                      ),
                    ),

                  )

                ],
              ),

            ],


          )

        ],
      ),
    );
  }
  void showMessage(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Exito'),
        content: const Text('Registro exitoso'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

}