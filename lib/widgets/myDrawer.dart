import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go2climb/screens/clients.dart';
import 'package:go2climb/screens/home.dart';
import 'package:go2climb/screens/profile-agency.dart';
import 'package:go2climb/screens/profile-tourist.dart';
import 'package:go2climb/widgets/login.dart';

class myDrawer extends StatefulWidget {
  const myDrawer({Key? key}) : super(key: key);

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {

  var storage = FlutterSecureStorage();

  String userType = '';
  String uId = '';


  @override
  void initState() {
    super.initState();
    setParams();
  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF9CD4E7),
            ),
            child: Text(''),
          ),
          ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Mi inicio'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              }
          ),
          if (userType == 'agency')
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileAgencyScreen(uId: uId)));
              }
          ),
          if (userType == 'customer')
            ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Perfil'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileTourist(uId: uId)));
                }
            ),
           if (userType == 'agency')
            ListTile(
              leading: const Icon(Icons.accessibility),
              title: const Text('Mis clientes'),
              onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Clients(uId: uId)));
                }
            ),
          if (userType == 'agency')
            const ListTile(
              leading: Icon(Icons.payment),
              title: Text('Cambiar Plan'),
            ),
          ListTile(
            leading: const Icon(Icons.output),
            title: const Text('Cerrar sesión'),
            onTap: (){
                logOut();

              }
          ),
        ],
      ),
    );
  }

  void setParams() async{
    var type = await storage.read(key: 'type');
    var id = await storage.read(key: 'id');
    setState(() {
      userType = type!;
      uId = id!;
    });
    print(uId);
  }

  void logOut() async{
    await storage.deleteAll();
    router();
  }

  void router(){
    Navigator.popUntil(context, (route) => route.isFirst);
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }
}
