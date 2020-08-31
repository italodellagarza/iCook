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
  // String imageReference = "https://www.clicandoeandando.com/wp-content/uploads/2016/06/Como-tirar-fotos-melhores-com-qualquer-c%C3%A2mera-macro.jpg";
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
    // TODO: implement initState
    carregarImagem(widget.receita['imagem']);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.receita['owner']);
    // getImagePath(widget.receita['imagem']);
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
            trailing: Icon(Icons.share),
          ),
          Container(
            child: Stack(
              children: <Widget>[
                imageReference != null
                    ? CachedNetworkImage(
                        imageUrl: imageReference,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    : Container(
                        height: 250,
                        child: Center(
                            child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ))),
                SizedBox(),
                Container(
                  color: Colors.black.withOpacity(
                      0.50), // comment or change to transparent color
                  height: 30.0,
                  width: 300.0,
                  child: Text(
                    widget.receita['nome'],
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(widget.receita['modo_preparo']),
          ),
          ButtonTheme(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  //playlist_add_check
                  child: Icon(Icons.playlist_add, color: Colors.red, size: 40),
                  onPressed: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//  void showAlert(BuildContext context) {
//    showDialog(
//      context: context,
//      builder: (context) => AlertDialog(
//        title: Center(
//          child: Text("Excluir"),
//        ),
//        content: Text("Tem certeza que quer excluir?"),
//        actions: <Widget>[
//          FlatButton(
//            child: Text("Sim"),
//            onPressed: () {
//              //Provider.of<Items>(context, listen: false).remove(item);
//              Navigator.of(context).pop();
//            },
//          ),
//          FlatButton(
//            child: Text("Não"),
//            onPressed: () {
//              Navigator.of(context).pop();
//            },
//
//          ),
//        ],
//      ),
//    );
//  }
