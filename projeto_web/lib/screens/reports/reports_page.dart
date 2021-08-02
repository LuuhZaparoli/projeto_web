import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projeto_web/models/relatorio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_web/screens/reports/exibir_relatorio.dart';

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
        db.collection("relatorios").snapshots().listen((snapshot){
          final List<Relatorio> relatorios = snapshot.docs
              .map(
              (documentsSnapshot) => Relatorio.fromMap(
                  documentsSnapshot.data(), documentsSnapshot.id)).toList();

          setState(() {
            this.item = relatorios;
          });
        });
  }

  @override
  void dispose(){
    //Cancelar a inscricao
    relatorioInscricao?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Lista de Relatórios"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getListaRelatorios(),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List<DocumentSnapshot> documentos =
                        snapshot.data.docs;
                    return ListView.builder(
                      itemCount: item.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(item[index].visita,
                            style: TextStyle(fontSize: 20)),
                          subtitle: Text(item[index].veiculo,
                          style: TextStyle(fontSize: 16)),
                          leading: Column(
                            children: <Widget>[
                              IconButton(
                                  icon: const Icon(Icons.delete_forever,),
                                  hoverColor: Colors.white10,
                                  tooltip: "Excluir",
                                  onPressed: (){
                                  _deletarRelatorio(
                                      context, documentos[index], index);
                                  }
                              )
                            ],
                          ),
                            onTap: ()=> _navegarParaRelatorio(context, item[index]),
                        );
                      },
                    );
                }
              }
            ),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> getListaRelatorios(){
    return FirebaseFirestore.instance.collection('relatorios').snapshots();
  }

  void _deletarRelatorio(BuildContext context, DocumentSnapshot doc, int position) async{
    db.collection("relatorios").doc(doc.id).delete();

    setState(() {
      item.removeAt(position);
    });
  }

  void _navegarParaRelatorio(BuildContext context, Relatorio relatorio) async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => ExibirRelatorio(relatorio)),
    );
  }

}
