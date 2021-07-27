import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GpsPage extends StatefulWidget {
  @override
  _GpsPageState createState() => _GpsPageState();
}

class _GpsPageState extends State<GpsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("GPS PAGE"),
      ),
      body: new Center(
          child: new Text("Pagina de GPS")
      ),
    );
  }
}
