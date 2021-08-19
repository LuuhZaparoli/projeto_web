import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_web/models/relatorio.dart';
import 'package:projeto_web/shared/texts.dart';

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
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(widget.relatorio.visita),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Fazenda visitada: ", style: textTitle),
              Text(widget.relatorio.visita, style: textContent),
              Text("\nColaborador: ", style: textTitle),
              Text(widget.relatorio.nome, style: textContent),
              Text("\nData da visita: ", style: textTitle),
              Text(widget.relatorio.data, style: textContent),
              Text("\nVeículo utilizado: ", style: textTitle),
              Text(widget.relatorio.veiculo, style: textContent),
              Text("\nQuilômetros percorridos: ", style: textTitle),
              Text(widget.relatorio.km.toString(), style: textContent),
              Text("\nHouve abastecimento: ", style: textTitle),
              Text(abastecimento, style: textContent),
              Text("\nLitros abastecidos: ", style: textTitle),
              Text(widget.relatorio.litros.toString(), style: textContent),
              Text("\nValor R\u0024: ", style: textTitle),
              Text(widget.relatorio.valor.toString(), style: textContent),
              Text("\nObservações: ", style: textTitle),
              Text(widget.relatorio.obs, style: textContent),
            ]
        ),
      ),
    );
  }
}
