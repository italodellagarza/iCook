import 'package:ICook/model/user.dart';
import 'package:ICook/recipe_tile.dart';
import 'package:flutter/material.dart';

import 'cadastrarreceitapage.dart';
import 'circularButton.dart';
import 'drawer_menu.dart';
import 'recipe_tile_personal_list.dart';

class PersonalListPage extends StatefulWidget {
  PersonalListPage({Key key, this.title, this.auth, this.logoutCallback})
      : super(key: key);
  final auth;
  final logoutCallback;
  final String title;

  @override
  _PersonalListPageState createState() => _PersonalListPageState();
}

class _PersonalListPageState extends State<PersonalListPage>
    with SingleTickerProviderStateMixin {
  Usuario user;

  void getUserInfo() async {
    var firebaseUser = await widget.auth.getCurrentUser();
    print(firebaseUser);
    setState(() {
      user = new Usuario(
          firebaseUser.email, firebaseUser.email, firebaseUser.email,
          avatar: firebaseUser.email);
    });
    // TODO: ajutar os dados do usuario
    print(user);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("imgs/icon.png"),
                    fit: BoxFit.fitHeight),
              ),
            ),
            SizedBox(width: 5),
            Text("iCook"),
          ],
        ),
        backgroundColor: Colors.black54,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.grey[300],
              child: ListView(
                children: <Widget>[
                  Container(
                    color: Colors.red.withOpacity(0.80), // comment or change to transparent color
                    height: 50.0,
                    width: 300.0,
                    child: Center(
                      child: Text("Minhas receitas", 
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                  RecipeTilePersonalList(),
                  RecipeTilePersonalList(),
                  RecipeTilePersonalList(),
                  RecipeTilePersonalList(),
                ],
              ),
            ),
            Positioned(
              right: 30,
              bottom: 30,
              child: CircularButton(
                color: Colors.green,
                width: 50,
                height: 50,
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                        CadastrarReceitasPage()
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
      //ListView.builder(
      //  itemCount: items.count,
      //  itemBuilder: (ctx, i) => ItemTile(items.byIndex(i)),
      //),
    );
  }
}
