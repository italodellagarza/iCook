import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class RecipeTilePersonalList extends StatefulWidget {
  RecipeTilePersonalList({this.receita});
  final receita;
  String imageReference;
  @override
  _RecipeTilePersonalListState createState() => _RecipeTilePersonalListState();
}

class _RecipeTilePersonalListState extends State<RecipeTilePersonalList> {
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
    // TODO: implement initState
    super.initState();
    carregarImagem(widget.receita['imagem']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            trailing: Icon(Icons.share),
          ),
          Container(
            child: Stack(
              children: <Widget>[
                widget.imageReference != null
                    ? CachedNetworkImage(
                        imageUrl: widget.imageReference,
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
                        )),
                      ),
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
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
