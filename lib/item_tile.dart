import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {

  //final Item item;
  
  //ItemTile(this.item);

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text("Excluir"),
        ),
        content: Text("Tem certeza que quer excluir?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Sim"),
            onPressed: () {
              //Provider.of<Items>(context, listen: false).remove(item);
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("Não"),
            onPressed: () {
              Navigator.of(context).pop();
            },
            
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //leading: CircleAvatar(child: Image.asset("imgs/list-icon.png")),
      //title: Text(item.name),
      //subtitle: Text(item.annotation),
      //trailing: Container(
      //  width: 100,
      //  child: Row(
      //    children: <Widget>[
      //      IconButton(
      //        icon: Icon(Icons.mode_edit, color: Colors.orange),
      //        onPressed: () {
      //          Navigator.of(context).pushNamed(
      //            AppRoutes.ITEM_FORM,
      //            arguments: item,
      //          );
      //        },
      //      ),
      //      IconButton(
      //        icon: Icon(Icons.delete_forever, color: Colors.red),
      //        onPressed: () {
      //          showAlert(context);
      //        },
      //      ),
      //    ],
      //  ),
      //),
    );
  }
}