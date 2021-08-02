import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_web/models/relatorio.dart';

class ExibirRelatorio extends StatefulWidget {

  final Relatorio relatorio;
  ExibirRelatorio(this.relatorio);

  @override
  _ExibirRelatorioState createState() => _ExibirRelatorioState();
}

class _ExibirRelatorioState extends State<ExibirRelatorio> {

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String abastecimento = widget.relatorio.abastecimento ? "Sim" : "Não";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.relatorio.visita),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
            children: <Widget>[
              Text("Fazenda visitada: " + widget.relatorio.visita),
              Text("Observações: " + widget.relatorio.obs),
              Text("Placa do veículo utilizado: " + widget.relatorio.veiculo),
              Text("Valor R: " + widget.relatorio.valor.toString()),
              Text("Litros abastecidos: " + widget.relatorio.litros.toString()),
              Text(
                  "Quilômetros percorridos: " + widget.relatorio.km.toString()),
              Text("Houve abastecimento: " + abastecimento),
            ]
        ),
      ),
    );
  }
}
