/*
  Componente: card aonde todas as informações das receitas presentes na tela principal
  podem ser visualizadas.
*/

import 'package:ICook/telaexpandirreceita.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class RecipeTile extends StatefulWidget {
  RecipeTile({this.receita, this.owner});
  final receita;
  final owner;
  @override
  _RecipeTileState createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  String imageReference;

  void getImagePath(String fileName) async {
    if (fileName != null) {
      StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
      imageReference = await firebaseStorageRef.getDownloadURL();
    }
  }

  void carregarImagem(String fileName) async {
    if (fileName != null) {
      StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
      firebaseStorageRef
        .getDownloadURL()
        .then((value) => setState(() => imageReference = value));
    }
  }

  @override
  void initState() {
    carregarImagem(widget.receita['imagem']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://previews.123rf.com/images/dxinerz/dxinerz1508/dxinerz150800924/43773803-chef-cooking-cook-icon-vector-image-can-also-be-used-for-activities-suitable-for-use-on-web-apps-mob.jpg'),
            ),
            title: Text("Usuário 1"),
            subtitle: Text("usuário1@gmail.com"),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Stack(
              children: <Widget>[
                imageReference != null
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
                    imageUrl: imageReference,
                    progressIndicatorBuilder:
                      (context, url, downloadProgress) =>
                        CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
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
                    )
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
                  child: Text("EXPANDIR"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => TelaExpandirReceita(
                          receita: widget.receita,
                          imageReference: imageReference,
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