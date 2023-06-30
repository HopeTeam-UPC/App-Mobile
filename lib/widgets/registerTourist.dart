
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go2climb/models/newCustomer.dart';
import 'package:go2climb/services/auth.dart';
import 'package:go2climb/widgets/registerTourist.dart';

import '../screens/home.dart';
class RegisterTourist extends StatefulWidget{
  @override
  _RegisterTouristFormState createState() => _RegisterTouristFormState();
}

class _RegisterTouristFormState extends State<RegisterTourist>{
  bool _obscureText = true;
  late String _name;
  late String _surname;
  late String _country;
  late String _phone;
  late String _email;
  late  String _password;
  bool isChecked = false;
  bool terms = false;

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
                "Informacion de la Cuenta",
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
                    hintText: "nombre del usuario",
                    labelText: "nombre del usuario",
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
              TextField(
                enableInteractiveSelection: false,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                    hintText: "Apellido",
                    border: OutlineInputBorder(
                    )
                ),
                onChanged: (valor){
                  _surname = valor;
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
                          hintText: "pais",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.0)
                              )
                          )
                      ),
                      onChanged: (valor){
                        _country = valor;
                      },
                    ),

                  )
                  ],
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
                  const Expanded(
                    child: Text(
                      "Declaro tener +18 años de edad",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(
                height: 20.0,
              ),

              Row(
                children: [
                  Expanded(
                    child: Checkbox(
                      value: terms,
                      onChanged: (value) {
                        setState(() {
                          terms = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: const Text(
                        "Acepto los terminos y condiciones",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: (){
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
                      onPressed: (){
                        register();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF9CD4E7)
                      ),
                      child: const Text("Finalizar"),
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
  void success(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Exito'),
        content: const Text('Se registro con exito'),
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

    newCustomer customer = newCustomer(name: _name, lastName: _surname, password: _password, email: _email, phoneNumber: _phone, img_url: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', type_user: 'customer');
    var json = jsonEncode(customer.toJson());
    var response = await authService.postTourist(json);
    if(response == 200){
      success();
    }
    else {
      showMessage();
    }
  }
}