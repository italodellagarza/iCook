import 'package:flutter/material.dart';

class RecipeTile extends StatefulWidget {
  @override
  _RecipeTileState createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://previews.123rf.com/images/dxinerz/dxinerz1508/dxinerz150800924/43773803-chef-cooking-cook-icon-vector-image-can-also-be-used-for-activities-suitable-for-use-on-web-apps-mob.jpg'
              ),
            ),
            title: Text("Usuário 1"),
            subtitle: Text("usuário1@gmail.com"),
            trailing: Icon(Icons.share),
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Image.asset("imgs/bolo.jpeg"),
                SizedBox(),
                Container(
                  color: Colors.black.withOpacity(0.50), // comment or change to transparent color
                  height: 30.0,
                  width: 300.0,
                  child: Text("Nome da receita", 
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text("Trata-se de uma situação de comunicação bastante recorrente, cujo aspecto instrutivo se revela pelos procedimentos a serem tomados mediante a realização, a feitura de um determinado prato gastronômico."),
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