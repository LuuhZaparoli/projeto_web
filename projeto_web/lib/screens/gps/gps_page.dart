import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projeto_web/models/userLocationFire.dart';

class GpsPage extends StatefulWidget {
  @override
  _GpsPage createState() => _GpsPage();
}

class _GpsPage extends State<GpsPage> {

  List<UserLocation> item;
  var db = FirebaseFirestore.instance;

  Completer<GoogleMapController> _controller = Completer();

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

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
          child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
        )
    );
  }
}

Stream<QuerySnapshot> getListaLocations() {
  return FirebaseFirestore.instance.collection('location').snapshots();
}