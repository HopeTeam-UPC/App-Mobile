import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go2climb/models/authModel.dart';
import 'package:go2climb/services/auth.dart';
import 'package:go2climb/widgets/registerAgency.dart';
import 'package:go2climb/widgets/registerTourist.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../screens/home.dart';


class Login extends StatefulWidget{
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<Login>{

  final storage = FlutterSecureStorage();
  bool _obscureText = true;
  bool userType = false;
  late String _email;
  late  String _password;

  late authModel creds;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Iniciar Sesion",
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
                enableInteractiveSelection: true,
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
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => forgetPassword()));
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(
                    color: Colors.white, // Color del texto resaltado
                    fontWeight: FontWeight.bold, // Estilo de fuente en negrita
                    ),
                  ),
                ),
                child: const Text("¿Has olvidado tu contraseña?"),
              ),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        loginTourist();

                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF9CD4E7)
                      ),
                      child: const Text("Iniciar Sesion Turista"),
                  ),
                  )

                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        loginAgency();

                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF9CD4E7)
                      ),
                      child: const Text("Iniciar Sesion Agencia"),
                    ),
                  )

                ],
              ),
              const Text("¿Aún no tienes una cuenta?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Row(
                children: [
                  Expanded(
                    child:  ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterTourist()));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF9CD4E7)
                      ),
                      child: const Text("Registrate y disfruta tu aventura"),
                  ),

                  )

                ],
              ),
              Row(
                children: [
                  Expanded(
                      child:  ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterAgency()));
                          },
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF9CD4E7)
                        ),
                          child: const Text("Registrate y ofrece servicios turisticos"),
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
  void navigate(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Future<void> loginTourist() async{

    creds = authModel(email: _email, password: _password);
    var json = creds.toJson();

    var response = await authService.loginTourist(json);
    var decoded = jsonDecode(response.body);

    if(response.statusCode == 200){
    await storage.write(key: 'id', value: decoded['user']['_id']);
    await storage.write(key: 'name', value: decoded['user']['name']);
    await storage.write(key: 'type', value: decoded['user']['type_user']);
    navigate();
    }
    else{
      showMessage();
    }

  }

  Future<void> loginAgency() async{

    creds = authModel(email: _email, password: _password);
    var json = creds.toJson();

    var response = await authService.loginAgency(json);
    var decoded = jsonDecode(response.body);
    //print(decoded);

    if(response.statusCode == 200){
      await storage.write(key: 'id', value: decoded['user']['_id']);
      await storage.write(key: 'name', value: decoded['user']['name']);
      await storage.write(key: 'type', value: decoded['user']['type_user']);
      navigate();
    }
    else{
      showMessage();
    }

  }

  void showMessage(){
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Email o contraseña incorrectos'),
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

class forgetPassword extends StatelessWidget{

  late String _email;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Recuperar Contraseña",
          ),
        ),
      ),
      body: Column(
        children:<Widget> [
          const Divider(
            height: 18.0,
          ),
          const Text(
            "Ingrese su correo electrónico",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            )
          ),
          const Divider(
            height: 18.0,
          ),
          TextField(
            enableInteractiveSelection: false,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              hintText: "correo electrónico",
              labelText: "correo electrónico",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0)
                )
              ),
            onSubmitted: (valor){
              _email = valor;
            },
          ),const Divider(
            height: 260.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child:  ElevatedButton(
                  child: Text("Continuar"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => smsForgetPassword()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF9CD4E7)
                  ),
                ),

              )

            ],
          ),
        ],
      ),
    );


  }
}







class smsForgetPassword extends StatelessWidget{
  late String _codigo;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text("Recuperar Contraseña",
          ),
        ),
      ),
      body: Column(
        children:<Widget> [
          Divider(
            height: 18.0,
          ),
          Text(
              "Ingrese el codigo de recuperacion",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              )
          ),
          Divider(
            height: 18.0,
          ),
          TextField(
            enableInteractiveSelection: false,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
                hintText: "Ingrese Codigo",
                labelText: "Ingrese Codigo",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)
                )
            ),
            onSubmitted: (valor){
              _codigo = valor;
            },
          ),Divider(
            height: 260.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child:  ElevatedButton(
                  child: Text("Continuar"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => newPassword()));
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF9CD4E7)
                  ),
                ),

              )

            ],
          ),
        ],
      ),
    );


  }
}

class newPassword extends StatelessWidget{
  late String _email;
  bool _obscureText = true;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text("Recuperar Contraseña",
          ),
        ),
      ),
      body: Column(
        children:<Widget> [
          Divider(
            height: 18.0,
          ),
          Text(
              "Ingrese una nueva contraseña",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              )
          ),
          Divider(
            height: 18.0,
          ),
          TextField(
            enableInteractiveSelection: false,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
                hintText: "Ingrese Nuevo Correo",
                labelText: "Ingrese Nuevo Correo",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)
                )
            ),
            onSubmitted: (valor){
              _email = valor;
            },
          ),Divider(
            height: 260.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child:  ElevatedButton(
                  child: Text("Finalizar"),
                  onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF9CD4E7)
                  ),
                ),

              )

            ],
          ),
        ],
      ),
    );

  }
}

