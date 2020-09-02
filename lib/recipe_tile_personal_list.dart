/*
  Componente: card aonde todas as informações das receitas presentes na tela da
  lista pessoal de receitas, podem ser visualizadas.
*/

import 'package:ICook/cadastrarreceitapage.dart';
import 'package:ICook/telaexpandirreceita.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ICook/model/user.dart';
import 'package:ICook/services/firestore.dart';

class RecipeTilePersonalList extends StatefulWidget {
  RecipeTilePersonalList({this.receita, this.imageReference});
  final receita;
  String imageReference;
  @override
  _RecipeTilePersonalListState createState() => _RecipeTilePersonalListState();
}

class _RecipeTilePersonalListState extends State<RecipeTilePersonalList> {
  Usuario user = Usuario("Usuario1", "usuario1@gmail.com", "");
  String imageReferenceUser;
  final firestore = new Database();

  void getImageUser() async {
    if (user != null) {
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(user.avatar);
      var reference = await firebaseStorageRef.getDownloadURL();
      setState(() {
        imageReferenceUser = reference;
      });
    }
  }

  void getOwnerInfo() async {
    var userSaved = await firestore
        .getCollection('usuario')
        .doc(widget.receita["owner"])
        .get();
    setState(() {
      user = new Usuario(userSaved.data()['nome'],
          userSaved.data()['sobrenome'], userSaved.data()['email'],
          avatar: userSaved.data()['avatar']);
    });
    getImageUser();
  }

  void carregarImagem(String fileName) async {
    if (fileName != null) {
      StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
      firebaseStorageRef
        .getDownloadURL()
        .then((value) => setState(() => widget.imageReference = value));
    }
  }

  @override
  void initState() {
    super.initState();
    carregarImagem(widget.receita['imagem']);
    getOwnerInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Stack(
              children: <Widget>[
                widget.imageReference != null
                ? Container(
                  height: 200,
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    imageUrl: widget.imageReference,
                    progressIndicatorBuilder:
                      (context, url, downloadProgress) =>
                        CircularProgressIndicator(
                          value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                  ),
                )
                : Container(
                    constraints: BoxConstraints(
                      minHeight: 200,
                      maxHeight: 200,
                    ),
                    height: 250,
                    child: Center(
                        child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                SizedBox(),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black.withOpacity(0.50),
                  height: 50.0,
                  width: double.infinity,
                  child: Text(
                    widget.receita['nome'],
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          ButtonTheme(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  //playlist_add_check
                  child: Text("EXPANDIR"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => TelaExpandirReceita(
                          receita: widget.receita,
                          imageReferenceUser: imageReferenceUser,
                          imageReference: widget.imageReference,
                          owner: user,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
