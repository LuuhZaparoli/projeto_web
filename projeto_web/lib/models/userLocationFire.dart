import 'package:cloud_firestore/cloud_firestore.dart';

class UserLocation{
  String _id;
  GeoPoint _geo;
  String _nome;

  UserLocation(this._id, this._geo, this._nome);

  UserLocation.map(dynamic obj){
    this._id = obj['id'];
    this._geo = obj['geo'];
    this._nome = obj['nome'];
  }

  String get id => _id;
  GeoPoint get location => _geo;
  String get nome => _nome;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['geo'] = _geo;
    map['nome'] = _nome;

    return map;
  }

  UserLocation.fromMap(Map<String, dynamic> map, String id){
    this._id = id ?? '';
    this._geo = map['geo'];
    this._nome = map['nome'];
  }
}