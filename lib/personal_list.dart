/*
  Tela para visualizar as receitas pessoais do usuário.
*/
import 'package:ICook/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cadastrarreceitapage.dart';
import 'circularButton.dart';
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
  String userUID;
  final firestore = new Database();

  void getUserInfo() async {
    var firebaseUser = await widget.auth.getCurrentUser();
    setState(() {
      userUID = firebaseUser.uid;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
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
              child: userUID != null
              ? StreamBuilder(
                stream: firestore
                  .getCollection('receita')
                  .where("owner", isEqualTo: userUID)
                  .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    print('Error ao carregar as minhas receitas');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return LinearProgressIndicator();
                    default:
                      return Container(
                        child: ListView(
                            children: snapshot.data.documents
                              .map<Widget>((DocumentSnapshot doc) {
                          return RecipeTilePersonalList(
                            receita: doc.data(),
                          );
                        }).toList()),
                      );
                  }
                },
              )
              : LinearProgressIndicator(),
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
                        CadastrarReceitasPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
