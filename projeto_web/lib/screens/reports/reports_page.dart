import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projeto_web/models/relatorio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_web/screens/reports/exibir_relatorio.dart';
import 'package:projeto_web/shared/loading.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<Relatorio> item;
  var db = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot> relatorioInscricao;

  @override
  void initState() {
    super.initState();

    item = List();
    relatorioInscricao?.cancel();

    relatorioInscricao =
        db.collection("relatorios").snapshots().listen((snapshot) {
      final List<Relatorio> relatorios = snapshot.docs
          .map((documentsSnapshot) =>
              Relatorio.fromMap(documentsSnapshot.data(), documentsSnapshot.id))
          .toList();

      setState(() {
        this.item = relatorios;
      });
    });
  }

  @override
  void dispose() {
    //Cancelar a inscricao
    relatorioInscricao?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: getListaRelatorios(),
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
                            title: Text(item[index].visita,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                            subtitle: Text(item[index].nome,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white30,
                                )),
                            leading: Column(
                              children: <Widget>[
                                IconButton(
                                    icon: const Icon(
                                      Icons.delete_forever,
                                    ),
                                    color: Colors.red[900],
                                    hoverColor: Colors.white10,
                                    splashRadius: 25,
                                    tooltip: "Excluir",
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title:
                                              const Text("Excluir relatório"),
                                          content: const Text(
                                              "Tem certeza que deseja excluir este relatório?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancelar'),
                                              child: const Text(
                                                'Cancelar',
                                                style: TextStyle(
                                                    color: Colors.blueGrey),
                                              ),
                                            ),
                                            SizedBox(width: 6),
                                            TextButton(
                                                child: const Text(
                                                  'Excluir',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _deletarRelatorio(context,
                                                      documentos[index], index);
                                                  Navigator.pop(
                                                      context, 'Excluir');
                                                }),
                                          ],
                                        ),
                                      );
                                    })
                              ],
                            ),
                            onTap: () =>
                                _navegarParaRelatorio(context, item[index]),
                          );
                        },
                      );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> getListaRelatorios() {
    return FirebaseFirestore.instance.collection('relatorios').snapshots();
  }

  void _deletarRelatorio(
      BuildContext context, DocumentSnapshot doc, int position) async {
    db.collection("relatorios").doc(doc.id).delete();

    setState(() {
      item.removeAt(position);
    });
  }

  void _navegarParaRelatorio(BuildContext context, Relatorio relatorio) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExibirRelatorio(relatorio)),
    );
  }
}
