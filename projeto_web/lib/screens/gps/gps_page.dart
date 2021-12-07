import 'dart:async';
import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projeto_web/models/userLocationFire.dart';
import 'package:projeto_web/shared/loading.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker_updates.dart';

class GpsPage extends StatefulWidget {
  @override
  _GpsPage createState() => _GpsPage();
}

class _GpsPage extends State<GpsPage> {
  List<UserLocation> item;
  final db = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot> locationInscricao;

  List<Marker> allMarkers = [];
  Timer _timer;

  GoogleMapController _controller;

  @override
  void initState() {
    super.initState();

    item = List();
    locationInscricao?.cancel();

    locationInscricao =
        db.collection("location").snapshots().listen((snapshot) {
          final List<UserLocation> locations = snapshot.docs
              .map((documentsSnapshot) => UserLocation.fromMap(
              documentsSnapshot.data(), documentsSnapshot.id))
              .toList();

          setState(() {
            this.item = locations;
          });
        });

    _timer = Timer.periodic(Duration(seconds: 30), (Timer t) => FillMarkers());
  }

  Future<void> FillMarkers() async {
    for (int i = 0; i < item.length; i++) {
      allMarkers.add(Marker(
          markerId: MarkerId(item[i].id),
          draggable: false,
          infoWindow: InfoWindow(title: item[i].nome),
          position:
          LatLng(item[i].location.latitude, item[i].location.longitude)));
    }
  }

  @override
  void dispose() {
    //Cancelar a inscricao
    locationInscricao?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        StreamBuilder<QuerySnapshot>(
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
                  FillMarkers();
                  return Center();
              }
            }),
        GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(-21.14325176099291, -47.79906495611895), zoom: 10.0),
          markers: Set<Marker>.from(allMarkers),
          mapType: MapType.normal,
          onMapCreated: mapCreated,
        )
      ]),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
}

Stream<QuerySnapshot> getListaLocations() {
  return FirebaseFirestore.instance.collection('location').snapshots();
}
