class Relatorio{
  String _id;
  String _veiculo;
  num _km;
  bool _abastecimento;
  num _litros;
  num _valor;
  String _visita;
  String _obs;

  Relatorio(this._id, this._veiculo, this._km, this._abastecimento, this._litros,
      this._valor, this._visita, this._obs);

  Relatorio.map(dynamic obj){
    this._id = obj['id'];
    this._veiculo = obj['veiculo'];
    this._km = obj['km'];
    this._abastecimento = obj['abastecimento'];
    this._litros = obj['litros'];
    this._valor = obj['valor'];
    this._visita = obj['visita'];
    this._obs = obj['obs'];
  }

  String get id => _id;
  String get veiculo => _veiculo;
  num get km => _km;
  bool get abastecimento => _abastecimento;
  num get litros => _litros;
  num get valor => _valor;
  String get visita => _visita;
  String get obs => _obs;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['veiculo'] = _veiculo;
    map['km'] = _km;
    map['abastecimento'] = _abastecimento;
    map['litros'] = _litros;
    map['valor'] = _valor;
    map['visita'] = _visita;
    map['obs'] = _obs;

    return map;
  }

  Relatorio.fromMap(Map<String, dynamic> map, String id){
    this._id = id ?? '';
    this._veiculo = map['veiculo'];
    this._km = map['km'];
    this._abastecimento = map['abastecimento'];
    this._litros = map['litros'];
    this._valor = map['valor'];
    this._visita = map['visita'];
    this._obs = map['obs'];
  }
}