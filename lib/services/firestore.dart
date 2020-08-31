import 'package:ICook/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../receita.dart';

abstract class BaseFirestore {
  Future<DocumentReference> cadastrarReceita(Receita receita, String uid);
  Future<void> cadastrarUsuario(Usuario usuario, String uid);
  CollectionReference getCollection(String collectionName);
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

  CollectionReference getCollection(String collectionName) {
    return firestore.collection(collectionName);
  }

  Future<void> cadastrarUsuario(Usuario usuario, String uid) {
    return firestore.collection('usuario').doc(uid).set({
      "nome": usuario.nome,
      "sobrenome": usuario.sobrenome,
      "avatar": usuario.avatar,
      "email": usuario.email
    });
  }
}
