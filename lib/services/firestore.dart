import 'package:cloud_firestore/cloud_firestore.dart';

import '../receita.dart';

abstract class BaseFirestore {
  Future<DocumentReference> cadastrarReceita(Receita receita, String uid);
}

class Database implements BaseFirestore {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentReference> cadastrarReceita(Receita receita, String uid) {
    return firestore.collection('receita').add({
      "nome": receita.nomeReceita,
      "rendimento": receita.rendimento,
      "tempo_preparo": receita.tempoPreparo,
      "modo_preparo": receita.modoDeFazer,
      "owner": uid,
      "imagem": receita.imagem != null ? receita.imagem : ''
    });
  }
}
