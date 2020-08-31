import 'package:flutter/material.dart';

class RecipeTilePersonalList extends StatefulWidget {
  @override
  _RecipeTilePersonalListState createState() => _RecipeTilePersonalListState();
}

class _RecipeTilePersonalListState extends State<RecipeTilePersonalList> {
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
                Image.asset("imgs/bolo.jpeg"),
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
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}