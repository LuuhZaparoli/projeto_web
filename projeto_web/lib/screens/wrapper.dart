import 'package:flutter/cupertino.dart';
import 'package:projeto_web/models/user.dart';
import 'package:projeto_web/screens/authenticate/authenticate.dart';
import 'package:projeto_web/screens/reports/reports_page.dart';
import 'package:projeto_web/screens/gps/gps_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_web/service/auth.dart';

import 'authenticate/register_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserUID>(context);

    if(user == null){
      return Authenticate();
    }else{
      return MyTabBar();
    }
  }
}

class MyTabBar extends StatefulWidget {
  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
  void initState(){
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: new AppBar(
        title: new Text("PROJETO"),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          TextButton.icon(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.only(right: 25.0)),
            ),
            label: Text(
              'Sair',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () async{
              await _auth.signOut();
            },
          )
        ],
        bottom: new TabBar(
          indicatorColor: Colors.black,
          controller: controller,
          tabs: <Tab>[
            new Tab(icon: Icon(Icons.library_add_check_outlined)),
            new Tab(icon: Icon(Icons.pin_drop_outlined)),
            new Tab(icon: Icon(Icons.access_alarms)),
          ]
        )
      ),
          body: new TabBarView(
        controller: controller,
      children: <Widget>[
        ReportsPage(),
        GpsPage(),
        RegisterPage(),
      ],
    ),
    );
  }
}