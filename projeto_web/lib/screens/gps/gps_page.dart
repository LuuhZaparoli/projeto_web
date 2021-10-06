import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_web/models/userLocationFire.dart';
import 'package:projeto_web/shared/loading.dart';

class GpsPage extends StatefulWidget {
  @override
  _GpsPageState createState() => _GpsPageState();
}

class _GpsPageState extends State<GpsPage> {
  List<UserLocation> item;
  var db = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot> locationInscricao;

  @override
  void initState() {
    super.initState();

    item = List();
    locationInscricao?.cancel();

    locationInscricao =
        db.collection("location").snapshots().listen((snapshot) {
          final List<UserLocation> locations = snapshot.docs
              .map((documentsSnapshot) =>
              UserLocation.fromMap(documentsSnapshot.data(), documentsSnapshot.id))
              .toList();

          setState(() {
            this.item = locations;
          });
        });
  }

  @override
  void dispose() {
    //Cancelar a inscricao
    locationInscricao?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("GPS PAGE"),
      ),
      body: new Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: getListaLocations(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Loading(),
                  );
                default:
                  List<DocumentSnapshot> documentos = snapshot.data.docs;
                  return ListView.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(item[index].nome,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueGrey,
                            )),
                        subtitle: Text(item[index].location.latitude.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            )),
                      );
                    },
                  );
              }
            }),
      ),
    );
  }
  Stream<QuerySnapshot> getListaLocations() {
    return FirebaseFirestore.instance.collection('location').snapshots();
  }
}
